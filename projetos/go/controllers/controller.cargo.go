package controllers

import (
	"encoding/json"
	"imports/entities"
	"imports/utilDB"
	"io"

	"net/http"

	_ "github.com/gorilla/mux"
)

func CargoInserir(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var cargo entities.Cargo

	err := json.NewDecoder(r.Body).Decode(&cargo)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "INSERT INTO CARGO (DESCRICAO) VALUES($1)", cargo.Descricao)
}

func CargoAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var cargo entities.Cargo

	err := json.NewDecoder(r.Body).Decode(&cargo)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "UPDATE CARGO SET DESCRICAO = $1 WHERE ID_CARGO = $2", cargo.Descricao, cargo.Id_Cargo)
}

func CargoDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var cargo entities.Cargo

	err := json.NewDecoder(r.Body).Decode(&cargo)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "DELETE FROM CARGO WHERE ID_CARGO = $1", cargo.Id_Cargo)
}

func CargoPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_CARGO, DESCRICAO FROM CARGO ORDER BY ID_CARGO")
	if err == nil {
		listaCargo := []entities.Cargo{}
		for _, element := range query {
			listaCargo = append(listaCargo, entities.Cargo{
				Id_Cargo:  element["id_cargo"].(int64),
				Descricao: element["descricao"].(string),
			})
		}

		err := json.NewEncoder(w).Encode(listaCargo)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, err.Error())
		}
	}
}
