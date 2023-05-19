package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

var db *sql.DB
var err error

func main() {
	rotas := mux.NewRouter().StrictSlash(true)

	rotas.HandleFunc("/equipe/inserirEquipe", inserirEquipe).Methods("POST")
	rotas.HandleFunc("/equipe/pegarTodasEquipes", pegarTodasEquipes).Methods("GET")

	var port = ":3000"
	fmt.Println("Server running in port:", port)
	log.Fatal(http.ListenAndServe(port, rotas))
}

func init() {
	stringConexao := "postgres://postgres:postgres@34.95.131.245/squadscrum?sslmode=disable"

	db, err = sql.Open("postgres", stringConexao)
	if err != nil {
		log.Fatal(err.Error())
	}
	err = db.Ping()
	if err != nil {
		log.Fatal(err.Error())
	}
}

type Equipe struct {
	Id_Equipe int    `json:"Id_Equipe"`
	Nome      string `json:"Nome"`
}

func inserirEquipe(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)
	var equipe = Equipe{}

	json.Unmarshal(jsonEquipe, &equipe)

	fmt.Println(equipe)

	linha := db.QueryRow("INSERT INTO EQUIPE (NOME) VALUES($1)", equipe.Nome)
	if linha.Err() == nil {
		w.Write([]byte("Registro Salvo Com Sucesso!!"))
	} else {
		w.Write([]byte("Fudeu Piá " + linha.Err().Error()))
	}
}

func pegarTodasEquipes(w http.ResponseWriter, r *http.Request) {
	rows, _ := db.Query("SELECT * FROM EQUIPE")
	equipe := []Equipe{}
	for rows.Next() {
		var e Equipe
		if err = rows.Scan(&e.Id_Equipe, &e.Nome); err != nil {
			log.Fatal(err.Error())
		}
		equipe = append(equipe, e)
	}

	response, _ := json.Marshal(equipe)
	w.Write(response)
}
