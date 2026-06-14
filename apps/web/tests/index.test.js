import test from "node:test"
import assert from "node:assert/strict"
import fs from "node:fs"
import path from "node:path"

test("index.html possui estrutura principal da tela", () => {
  const htmlPath = path.resolve("index.html")
  const html = fs.readFileSync(htmlPath, "utf8")

  assert.ok(html.includes("<form"), "deve conter um formulario")
  assert.ok(html.includes("<input"), "deve conter um input")
  assert.ok(html.includes("<button"), "deve conter um botao")
  assert.ok(
    html.includes("static/scripts.js"),
    "deve carregar o script principal",
  )
})
