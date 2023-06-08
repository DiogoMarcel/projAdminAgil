package conexaobd

import (
	"database/sql"
	"log"
)

var Db *sql.DB
var err error

func InitBD() {
	stringConexao := "postgres://postgres:postgres@34.95.143.235/squadscrum?sslmode=disable"

	Db, err = sql.Open("postgres", stringConexao)
	if err != nil {
		log.Fatal(err.Error())
	}
	err = Db.Ping()
	if err != nil {
		log.Fatal(err.Error())
	}
}

func CloseDB() {
	Db.Close()
}
