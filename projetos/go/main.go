package main

import (
	"fmt"
	conexao "imports/conexaoBD"
	"imports/estruturas"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

func main() {
	defer conexao.CloseDB()

	rotas := mux.NewRouter().StrictSlash(true)

	var equipe = estruturas.Equipe{}
	rotas.HandleFunc("/equipe/inserirEquipe", equipe.Inserir).Methods("POST")
	rotas.HandleFunc("/equipe/alterarEquipe", equipe.Alterar).Methods("PATCH")
	rotas.HandleFunc("/equipe/deletarEquipe", equipe.Deletar).Methods("DELETE")
	rotas.HandleFunc("/equipe/pegarTodasEquipes", equipe.PegarTodos).Methods("GET")

	var cargo = estruturas.Cargo{}
	rotas.HandleFunc("/cargo/inserirCargo", cargo.Inserir).Methods("POST")
	rotas.HandleFunc("/cargo/alterarCargo", cargo.Alterar).Methods("PATCH")
	rotas.HandleFunc("/cargo/deletarCargo", cargo.Deletar).Methods("DELETE")
	rotas.HandleFunc("/cargo/pegarTodosCargos", cargo.PegarTodos).Methods("GET")

	var port = "127.0.0.1:3000"
	fmt.Println("Server running in port:", port)
	log.Fatal(http.ListenAndServe(port, rotas))
}

func init() {
	conexao.InitBD()
}
