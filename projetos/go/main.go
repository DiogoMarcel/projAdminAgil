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
	rotas.HandleFunc("/equipe/inserir", equipe.Inserir).Methods(http.MethodPost)
	rotas.HandleFunc("/equipe/alterar", equipe.Alterar).Methods(http.MethodPatch)
	rotas.HandleFunc("/equipe/deletar", equipe.Deletar).Methods(http.MethodDelete)
	rotas.HandleFunc("/equipe/pegarTodos", equipe.PegarTodos).Methods(http.MethodGet)

	var cargo = estruturas.Cargo{}
	rotas.HandleFunc("/cargo/inserir", cargo.Inserir).Methods(http.MethodPost)
	rotas.HandleFunc("/cargo/alterar", cargo.Alterar).Methods(http.MethodPatch)
	rotas.HandleFunc("/cargo/deletar", cargo.Deletar).Methods(http.MethodDelete)
	rotas.HandleFunc("/cargo/pegarTodos", cargo.PegarTodos).Methods(http.MethodGet)

	var empresa = estruturas.Empresa{}
	rotas.HandleFunc("/empresa/inserir", empresa.Inserir).Methods(http.MethodPost)
	rotas.HandleFunc("/empresa/alterar", empresa.Alterar).Methods(http.MethodPatch)
	rotas.HandleFunc("/empresa/deletar", empresa.Deletar).Methods(http.MethodDelete)
	rotas.HandleFunc("/empresa/pegarTodos", empresa.PegarTodos).Methods(http.MethodGet)

	var funcao = estruturas.Funcao{}
	rotas.HandleFunc("/funcao/inserir", funcao.Inserir).Methods(http.MethodPost)
	rotas.HandleFunc("/funcao/alterar", funcao.Alterar).Methods(http.MethodPatch)
	rotas.HandleFunc("/funcao/deletar", funcao.Deletar).Methods(http.MethodDelete)
	rotas.HandleFunc("/funcao/pegarTodos", funcao.PegarTodos).Methods(http.MethodGet)

	var colaborador = estruturas.Colaborador{}
	rotas.HandleFunc("/colaborador/inserir", colaborador.Inserir).Methods(http.MethodPost)
	rotas.HandleFunc("/colaborador/alterar", colaborador.Alterar).Methods(http.MethodPatch)
	rotas.HandleFunc("/colaborador/deletar", colaborador.Deletar).Methods(http.MethodDelete)
	rotas.HandleFunc("/colaborador/pegarTodos", colaborador.PegarTodos).Methods(http.MethodGet)

	var port = "127.0.0.1:3000"
	fmt.Println("Server running in port:", port)
	log.Fatal(http.ListenAndServe(port, rotas))
}

func init() {
	conexao.InitBD()
}
