package controllers

import (
	"encoding/json"
	"imports/entities"
	"imports/utilDB"
	"io"
	"net/http"
	"time"

	_ "github.com/gorilla/mux"
)

func SprintInserir(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var sprint entities.Sprint

	err := json.NewDecoder(r.Body).Decode(&sprint)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "INSERT INTO SPRINT (NOME,DATAINICIO,DATAFINAL) VALUES($1, $2, $3)",
		sprint.Nome, sprint.DataInicio, sprint.DataFinal)
}

func SprintAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var sprint entities.Sprint

	err := json.NewDecoder(r.Body).Decode(&sprint)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "UPDATE SPRINT SET NOME=$1, DATAINICIO=$2, DATAFINAL=$3 WHERE ID_SPRINT = $4",
		sprint.Nome, sprint.DataInicio, sprint.DataFinal, sprint.Id_Sprint)
}

func SprintDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var sprint entities.Sprint

	err := json.NewDecoder(r.Body).Decode(&sprint)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "DELETE FROM SPRINT WHERE ID_SPRINT = $1", sprint.Id_Sprint)
}

func SprintPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w,
		"SELECT S.ID_SPRINT"+
			" , S.NOME"+
			" , S.DATAINICIO"+
			" , S.DATAFINAL"+
			" , COALESCE(SP.ID_SPRINTPESQUISA,0) ID_SPRINTPESQUISA"+
			" , COALESCE(SP.IDPESQUISA,0) IDPESQUISA"+
			" , COALESCE(SP.IDSPRINT,0) IDSPRINT"+
			" FROM SPRINT S "+
			" LEFT JOIN SPRINT_PESQUISA SP "+
			" ON S.ID_SPRINT = SP.IDSPRINT "+
			" ORDER BY ID_SPRINT")
	if err == nil {
		listaSprint := []entities.Sprint{}
		for _, element := range query {
			listaSprint = append(listaSprint, entities.Sprint{
				Id_Sprint:  element["id_sprint"].(int64),
				DataInicio: element["datainicio"].(time.Time),
				DataFinal:  element["datafinal"].(time.Time),
				Nome:       element["nome"].(string),
				SprintPesquisa: &entities.SprintPesquisa{
					Id_SprintPesquisa: element["id_sprintpesquisa"].(int64),
					IdPesquisa:        element["idpesquisa"].(int64),
					IdSprint:          element["idsprint"].(int64),
				},
			})
		}

		err = json.NewEncoder(w).Encode(listaSprint)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, err.Error())
		}
	}
}
