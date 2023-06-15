package controllers

import (
	"encoding/json"
	"imports/entities"
	"imports/utilDB"
	"io"
	"net/http"

	_ "github.com/gorilla/mux"
)

func FuncaoInserir(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var funcao entities.Funcao

	err := json.NewDecoder(r.Body).Decode(&funcao)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "INSERT INTO FUNCAO (DESCRICAO) VALUES($1)", funcao.Descricao)
}

func FuncaoAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var funcao entities.Funcao

	err := json.NewDecoder(r.Body).Decode(&funcao)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "UPDATE FUNCAO SET DESCRICAO = $1 WHERE ID_FUNCAO = $2", funcao.Descricao, funcao.Id_Funcao)
}

func FuncaoDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var funcao entities.Funcao

	err := json.NewDecoder(r.Body).Decode(&funcao)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "DELETE FROM FUNCAO WHERE ID_FUNCAO = $1", funcao.Id_Funcao)
}

func FuncaoPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_FUNCAO, DESCRICAO FROM FUNCAO ORDER BY ID_FUNCAO")
	if err == nil {
		listaFuncao := []entities.Funcao{}

		for _, element := range query {
			listaFuncao = append(listaFuncao, entities.Funcao{
				Id_Funcao: element["id_funcao"].(int64),
				Descricao: element["descricao"].(string),
			})
		}

		err = json.NewEncoder(w).Encode(listaFuncao)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, err.Error())
		}
	}
}
