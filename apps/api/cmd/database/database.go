package database

import (
	"context"
	"database/sql"
	"fmt"
	"os"
	"time"
	"wheater/cmd/models"

	_ "github.com/lib/pq"
)

var db *sql.DB

func Connect() error {
	dsn := os.Getenv("DB_URL")
	if dsn == "" {
		dsn = "postgres://postgres:postgres@localhost:5433/weather_app?sslmode=disable"
	}

	conn, err := sql.Open("postgres", dsn)
	if err != nil {
		return fmt.Errorf("open database connection: %w", err)
	}

	conn.SetMaxOpenConns(10)
	conn.SetMaxIdleConns(5)
	conn.SetConnMaxLifetime(time.Hour)

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := conn.PingContext(ctx); err != nil {
		return fmt.Errorf("ping database: %w", err)
	}

	db = conn

	return migrate(ctx)
}

func Ping(ctx context.Context) error {
	if db == nil {
		return fmt.Errorf("database is not connected")
	}

	return db.PingContext(ctx)
}

func SaveWeatherSearch(ctx context.Context, data models.WeatherData) error {
	if db == nil {
		return fmt.Errorf("database is not connected")
	}
	if len(data.Weather) == 0 {
		return fmt.Errorf("weather response does not include weather details")
	}

	_, err := db.ExecContext(
		ctx,
		`INSERT INTO weather_searches (city, temperature, humidity, description, icon)
		 VALUES ($1, $2, $3, $4, $5)`,
		data.Name,
		int(data.Main.Celsius),
		data.Main.Humidity,
		data.Weather[0].Description,
		data.Weather[0].Icon,
	)
	if err != nil {
		return fmt.Errorf("insert weather search: %w", err)
	}

	return nil
}

func migrate(ctx context.Context) error {
	_, err := db.ExecContext(ctx, `
		CREATE TABLE IF NOT EXISTS weather_searches (
			id SERIAL PRIMARY KEY,
			city TEXT NOT NULL,
			temperature INTEGER NOT NULL,
			humidity INTEGER NOT NULL,
			description TEXT NOT NULL,
			icon TEXT NOT NULL,
			created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
		)
	`)
	if err != nil {
		return fmt.Errorf("run database migration: %w", err)
	}

	return nil
}
