package main

import (
	"fmt"
	conexao "imports/conexaoBD"
	crudbd "imports/crudBD"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

func main() {
	rotas := mux.NewRouter().StrictSlash(true)

	rotas.HandleFunc("/equipe/inserirEquipe", crudbd.InserirEquipe).Methods("POST")
	rotas.HandleFunc("/equipe/alterarEquipe", crudbd.AlterarEquipe).Methods("POST")
	rotas.HandleFunc("/equipe/deletarEquipe", crudbd.DeletarEquipe).Methods("DELETE")
	rotas.HandleFunc("/equipe/pegarTodasEquipes", crudbd.PegarTodasEquipes).Methods("GET")

	var port = "127.0.0.1:3000"
	fmt.Println("Server running in port:", port)
	log.Fatal(http.ListenAndServe(port, rotas))
}

func init() {
	conexao.InitBD()
}
