package crudbd

import (
	"imports/estruturas"
	"net/http"
)

func InserirEquipe(w http.ResponseWriter, r *http.Request) {
	var equipe = estruturas.Equipe{}
	equipe.Inserir(w, r)
}

func AlterarEquipe(w http.ResponseWriter, r *http.Request) {
	var equipe = estruturas.Equipe{}
	equipe.Alterar(w, r)
}

func DeletarEquipe(w http.ResponseWriter, r *http.Request) {
	var equipe = estruturas.Equipe{}
	equipe.Deletar(w, r)
}

func PegarTodasEquipes(w http.ResponseWriter, r *http.Request) {
	equipe := estruturas.Equipe{}
	equipe.PegarTodos(w, r)
}
