package crudbd

import (
	"imports/estruturas"
	"net/http"
)

func InserirCargo(w http.ResponseWriter, r *http.Request) {
	var cargo = estruturas.Cargo{}
	cargo.Inserir(w, r)
}

func AlterarCargo(w http.ResponseWriter, r *http.Request) {
	var cargo = estruturas.Cargo{}
	cargo.Alterar(w, r)
}

func DeletarCargo(w http.ResponseWriter, r *http.Request) {
	var cargo = estruturas.Cargo{}
	cargo.Deletar(w, r)
}

func PegarTodosCargos(w http.ResponseWriter, r *http.Request) {
	var cargo = estruturas.Cargo{}
	cargo.PegarTodos(w, r)
}
