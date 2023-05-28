package conexaobd

import (
	"database/sql"
	"log"
)

var Db *sql.DB
var err error

func InitBD() {
	stringConexao := "postgres://postgres:postgres@104.198.69.106/squadscrum?sslmode=disable"

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
