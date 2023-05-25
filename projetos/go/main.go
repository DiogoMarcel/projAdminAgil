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
	rotas.HandleFunc("/equipe/inserirEquipe", equipe.Inserir).Methods(http.MethodPost)
	rotas.HandleFunc("/equipe/alterarEquipe", equipe.Alterar).Methods(http.MethodPatch)
	rotas.HandleFunc("/equipe/deletarEquipe", equipe.Deletar).Methods(http.MethodDelete)
	rotas.HandleFunc("/equipe/pegarTodosEquipes", equipe.PegarTodos).Methods(http.MethodGet)

	var cargo = estruturas.Cargo{}
	rotas.HandleFunc("/cargo/inserirCargo", cargo.Inserir).Methods(http.MethodPost)
	rotas.HandleFunc("/cargo/alterarCargo", cargo.Alterar).Methods(http.MethodPatch)
	rotas.HandleFunc("/cargo/deletarCargo", cargo.Deletar).Methods(http.MethodDelete)
	rotas.HandleFunc("/cargo/pegarTodosCargos", cargo.PegarTodos).Methods(http.MethodGet)

	var empresa = estruturas.Empresa{}
	rotas.HandleFunc("/cargo/inserirEmpresa", empresa.Inserir).Methods(http.MethodPost)
	rotas.HandleFunc("/cargo/alterarEmpresa", empresa.Alterar).Methods(http.MethodPatch)
	rotas.HandleFunc("/cargo/deletarEmpresa", empresa.Deletar).Methods(http.MethodDelete)
	rotas.HandleFunc("/cargo/pegarTodosEmpresas", empresa.PegarTodos).Methods(http.MethodGet)

	var port = "127.0.0.1:3000"
	fmt.Println("Server running in port:", port)
	log.Fatal(http.ListenAndServe(port, rotas))
}

func init() {
	conexao.InitBD()
}
