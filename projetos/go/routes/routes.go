package routes

import (
	"imports/estruturas"
	"net/http"

	"github.com/gorilla/mux"
)

var RegisterStoreRoutes = func(router *mux.Router) {
	var equipe = estruturas.Equipe{}
	router.HandleFunc("/equipe/inserir", equipe.Inserir).Methods(http.MethodPost)
	router.HandleFunc("/equipe/alterar", equipe.Alterar).Methods(http.MethodPatch)
	router.HandleFunc("/equipe/deletar", equipe.Deletar).Methods(http.MethodDelete)
	router.HandleFunc("/equipe/pegarTodos", equipe.PegarTodos).Methods(http.MethodGet)

	var cargo = estruturas.Cargo{}
	router.HandleFunc("/cargo/inserir", cargo.Inserir).Methods(http.MethodPost)
	router.HandleFunc("/cargo/alterar", cargo.Alterar).Methods(http.MethodPatch)
	router.HandleFunc("/cargo/deletar", cargo.Deletar).Methods(http.MethodDelete)
	router.HandleFunc("/cargo/pegarTodos", cargo.PegarTodos).Methods(http.MethodGet)

	var empresa = estruturas.Empresa{}
	router.HandleFunc("/empresa/inserir", empresa.Inserir).Methods(http.MethodPost)
	router.HandleFunc("/empresa/alterar", empresa.Alterar).Methods(http.MethodPatch)
	router.HandleFunc("/empresa/deletar", empresa.Deletar).Methods(http.MethodDelete)
	router.HandleFunc("/empresa/pegarTodos", empresa.PegarTodos).Methods(http.MethodGet)

	var funcao = estruturas.Funcao{}
	router.HandleFunc("/funcao/inserir", funcao.Inserir).Methods(http.MethodPost)
	router.HandleFunc("/funcao/alterar", funcao.Alterar).Methods(http.MethodPatch)
	router.HandleFunc("/funcao/deletar", funcao.Deletar).Methods(http.MethodDelete)
	router.HandleFunc("/funcao/pegarTodos", funcao.PegarTodos).Methods(http.MethodGet)

	var colaborador = estruturas.Colaborador{}
	router.HandleFunc("/colaborador/inserir", colaborador.Inserir).Methods(http.MethodPost)
	router.HandleFunc("/colaborador/alterar", colaborador.Alterar).Methods(http.MethodPatch)
	router.HandleFunc("/colaborador/deletar", colaborador.Deletar).Methods(http.MethodDelete)
	router.HandleFunc("/colaborador/pegarTodos", colaborador.PegarTodos).Methods(http.MethodGet)
}
