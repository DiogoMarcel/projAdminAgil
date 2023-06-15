package controllers

import (
	"encoding/json"
	"imports/entities"
	"imports/utilDB"
	"io"

	"net/http"

	_ "github.com/gorilla/mux"
)

func EquipeInserir(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var equipe entities.Equipe

	err := json.NewDecoder(r.Body).Decode(&equipe)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "INSERT INTO EQUIPE (NOME) VALUES($1)", equipe.Nome)
}

func EquipeAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var equipe entities.Equipe

	err := json.NewDecoder(r.Body).Decode(&equipe)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "UPDATE EQUIPE SET NOME = $1 WHERE ID_EQUIPE = $2", equipe.Nome, equipe.Id_Equipe)
}

func EquipeDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var equipe entities.Equipe

	err := json.NewDecoder(r.Body).Decode(&equipe)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "DELETE FROM EQUIPE WHERE ID_EQUIPE = $1", equipe.Id_Equipe)
}

func EquipePegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_EQUIPE, NOME FROM EQUIPE ORDER BY ID_EQUIPE")
	if err == nil {
		listaEquipe := []entities.Equipe{}

		for _, element := range query {
			listaEquipe = append(listaEquipe, entities.Equipe{
				Id_Equipe: element["id_equipe"].(int64),
				Nome:      element["nome"].(string),
			})
		}

		err = json.NewEncoder(w).Encode(listaEquipe)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, err.Error())
		}
	}
}
