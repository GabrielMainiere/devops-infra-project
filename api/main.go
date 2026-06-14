package main

import (
	"log"
	"net/http"
	"wheater/cmd/database"
	"wheater/cmd/handlers"

	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	if err := godotenv.Load(); err != nil {
		log.Println("No .env file loaded, using environment variables")
	}

	if err := database.Connect(); err != nil {
		log.Fatal(err)
	}

	e := echo.New()

	e.Use(middleware.Recover())
	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodDelete, http.MethodOptions},
		AllowHeaders: []string{"Content-Type", "Accept"},
	}))

	e.GET("/getweather/:city", handlers.GetWheater)
	e.GET("/health", handlers.Health)

	e.Logger.Fatal(e.Start(":8002"))
}
