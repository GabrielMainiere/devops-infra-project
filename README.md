# Weather DevOps Project

Repositorio original utilizado como base: https://github.com/ecbDeveloper/wheater-web-app

O objetivo deste repositorio foi adicionar a camada de infraestrutura ao projeto, sem alterar a regra de negocio principal da aplicacao.

## Aplicacoes principais

O projeto base possui duas aplicacoes principais: um frontend web e uma API backend.

| Aplicacao    | Linguagem / stack            | Responsabilidade                                                                                       | Rotas principais               |
| ------------ | ---------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------ |
| Frontend web | HTML, CSS, JavaScript e Vite | Interface usada pelo usuario para pesquisar o clima de uma cidade. Consome a API backend pelo gateway. | `/`, `/static/*`, `/assets/*`  |
| API de clima | Go com Echo                  | Consulta dados de clima, retorna a resposta para o frontend e registra a busca no PostgreSQL.          | `/health`, `/getweather/:city` |

No acesso externo, a API fica disponivel pelo gateway com o prefixo `/api`:

```text
/api/health
/api/getweather/:city
```

O ambiente de homologacao fica publicado pelo gateway com o prefixo `/hom`:

```text
/hom/
/hom/api/health
/hom/api/getweather/:city
```

## Infraestrutura

Principais diretorios:

```text
api/                  API Go
web/                  Frontend
infra/gateway/        Configuracao do Nginx Gateway
infra/kubernetes/     Manifests Kubernetes da API e banco
infra/terraform/      Provisionamento da infraestrutura Azure
infra/ansible/        Playbooks de deploy
.github/workflows/    Pipeline CI/CD
```

## Docker

A API e o frontend possuem Dockerfile proprio.

Imagens publicadas no Docker Hub:

```text
mainiere/weather-api:latest
mainiere/weather-web:latest
```

A API usa build multi-stage para gerar uma imagem final menor com o binario Go.

## Kubernetes

O AKS executa:

- API Go com `Deployment`, 2 replicas e `RollingUpdate`.
- `Service` interno para a API.
- `Ingress` interno para receber chamadas vindas do gateway.
- `HorizontalPodAutoscaler` com target de CPU em 60%, como pedido.
- `ResourceQuota` e `LimitRange` nos namespaces `weather-hom` e `weather-prod`.
- Probes de liveness e readiness na rota `/health`.
- PostgreSQL com `StatefulSet`, primary e replicas de leitura.

O projeto usa dois namespaces no AKS:

```text
weather-hom    ambiente de homologacao, usado no DAST
weather-prod   ambiente de producao
```

## Banco de dados

O banco escolhido foi PostgreSQL.

Ele roda dentro do Kubernetes usando StatefulSet:

- `postgres-primary`: instancia principal usada pela API.
- `postgres-read`: cluster de leitura com 2 pods.

A aplicacao usa o service interno:

```text
postgres-primary:5432
```

## Terraform

Terraform provisiona a infraestrutura na Azure em modulos:

```text
modules/network   Resource Group, VNet, subnets e NSG
modules/compute   VM Linux com IP publico
modules/aks       Cluster AKS com 2 worker nodes
```

Comandos principais:

```bash
cd infra/terraform
terraform init
terraform validate
terraform plan
terraform apply
```

## Ansible

O deploy e feito com dois playbooks:

```text
deploy-k8s.yaml      Aplica API e banco no AKS
deploy-docker.yaml   Atualiza frontend e Nginx Gateway na VM
```

O playbook do AKS usa `kubectl` para aplicar os manifests. Ele nao acessa diretamente os worker nodes.

O playbook da VM acessa por SSH, instala dependencias, faz pull da imagem do frontend, reinicia o container e aplica a configuracao do Nginx.

## CI/CD

O pipeline fica em:

```text
.github/workflows/pipeline.yaml
```

Etapas principais:

- Testes unitarios da API Go e do frontend.
- SonarQube em container no ambiente de CI, com Quality Gate.
- Trivy para scan da imagem Docker da API.
- Build e push das imagens para o Docker Hub.
- Deploy via Ansible.
- OWASP ZAP baseline contra o gateway de homologacao.
- Resumo final por `echo`.

O arquivo `infra/kubernetes/api-secret.yaml` nao e versionado. No CI ele e gerado a partir da secret `OPENWEATHER_API_KEY`.

Secrets esperadas:

```text
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
KUBE_CONFIG_DATA
AZURE_VM_SSH_PRIVATE_KEY
API_GATEWAY_PUBLIC_IP
OPENWEATHER_API_KEY
GATEWAY_HOM_URL
```

## Validacao

Com a infraestrutura em execucao, os testes principais sao:

```bash
curl http://<GATEWAY_PUBLIC_IP>/
curl http://<GATEWAY_PUBLIC_IP>/api/health
curl http://<GATEWAY_PUBLIC_IP>/api/getweather/salvador
curl http://<GATEWAY_PUBLIC_IP>/hom/
curl http://<GATEWAY_PUBLIC_IP>/hom/api/health
```

Resultados esperados:

- `/` retorna o frontend.
- `/api/health` retorna `"All is working!"`.
- `/api/getweather/salvador` retorna um JSON com dados de clima.
- `/hom/` e `/hom/api/health` validam o ambiente de homologacao.

Para validar o AKS:

```bash
kubectl get nodes
kubectl get pods -n weather-hom
kubectl get svc -n weather-hom
kubectl get ingress -n weather-hom
kubectl get hpa -n weather-hom
kubectl get pods -n weather-prod
kubectl get svc -n weather-prod
kubectl get ingress -n weather-prod
kubectl get hpa -n weather-prod
```
