package handlers

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/labstack/echo/v4"
)

func TestHealth(t *testing.T) {
	e := echo.New()

	req := httptest.NewRequest(http.MethodGet, "/health", nil)
	rec := httptest.NewRecorder()

	c := e.NewContext(req, rec)

	err := Health(c)

	if err != nil {
		t.Fatalf("esperava erro nil, recebeu: %v", err)
	}

	if rec.Code != http.StatusOK {
		t.Fatalf("esperava status 200, recebeu: %d", rec.Code)
	}

	if !strings.Contains(rec.Body.String(), "All is working!") {
		t.Fatalf("Mensagem incorreta: %s", rec.Body.String())
	}
}