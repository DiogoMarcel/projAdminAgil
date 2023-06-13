package controllers

import (
	"database/sql"
	"encoding/json"
	conexaobd "imports/conexaoBD"
	"imports/entities"
	"imports/utilDB"
	"io"
	"net/http"

	_ "github.com/gorilla/mux"
)

func SprintPesquisaInserir(w http.ResponseWriter, r *http.Request) {
	var err error
	var tx *sql.Tx

	w.Header().Set("content-Type", "application/json")
	var sprintPesquisa entities.SprintPesquisa
	jsonSprintPesquisa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonSprintPesquisa, &sprintPesquisa)

	tx, err = conexaobd.Db.Begin()
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte("Erro no Servidor GO: " + err.Error()))
	}

	tx.Exec("DELETE FROM SPRINT_PESQUISA WHERE ID_SPRINTPESQUISA = $1",
		sprintPesquisa.Id_SprintPesquisa)

	var insertId int
	tx.QueryRow("INSERT INTO SPRINT_PESQUISA (IDPESQUISA,IDSPRINT) VALUES($1,$2) RETURNING ID_SPRINTPESQUISA",
		sprintPesquisa.IdPesquisa, sprintPesquisa.IdSprint).Scan(&insertId)

	if err == nil {
		err = tx.Commit()
		if err == nil {
			response, _ := json.Marshal(map[string]int{"insertId": insertId})
			if err == nil {
				w.Write([]byte(response))
			} else {
				w.WriteHeader(http.StatusBadRequest)
				w.Write([]byte("Erro ao gerar o Json no Controller.Sprint.Pesquisa no Servidor GO: " + err.Error()))
			}
		} else {
			tx.Rollback()
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte("Erro ao Commitar a Transacao no Servidor GO: " + err.Error()))
		}
	} else {
		w.WriteHeader(http.StatusBadRequest)
		err = tx.Rollback()
		if err == nil {
			w.Write([]byte("Erro ao Commitar a Transacao no Servidor GO: " + err.Error()))
		} else {
			w.Write([]byte("Erro ao efetuar o Roolback da Transacao no Servidor GO: " + err.Error()))
		}
	}
}

func SprintPesquisaAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var sprintPesquisa entities.SprintPesquisa
	jsonSprintPesquisa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonSprintPesquisa, &sprintPesquisa)

	utilDB.ExecutarSQL(w, "UPDATE SPRINT_PESQUISA SET IDPESQUISA=$1,IDSPRINT=$2 WHERE ID_SPRINTPESQUISA=$3",
		sprintPesquisa.IdPesquisa, sprintPesquisa.IdSprint, sprintPesquisa.Id_SprintPesquisa)
}

func SprintPesquisaDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var sprintPesquisa entities.SprintPesquisa
	jsonSprintPesquisa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonSprintPesquisa, &sprintPesquisa)

	utilDB.ExecutarSQL(w, "DELETE FROM SPRINT_PESQUISA WHERE ID_SPRINTPESQUISA = $1", sprintPesquisa.Id_SprintPesquisa)
}

func SprintPesquisaPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_SPRINTPESQUISA,IDPESQUISA,IDSPRINT FROM SPRINT_PESQUISA ORDER BY ID_SPRINTPESQUISA")

	if err == nil {
		listaSprintPesquisa := []entities.SprintPesquisa{}

		for _, element := range query {
			listaSprintPesquisa = append(listaSprintPesquisa, entities.SprintPesquisa{
				Id_SprintPesquisa: element["id_sprintpesquisa"].(int64),
				IdPesquisa:        element["idpesquisa"].(int64),
				IdSprint:          element["idsprint"].(int64),
			})
		}

		response, err := json.Marshal(listaSprintPesquisa)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte(err.Error()))
		}
	}
}
