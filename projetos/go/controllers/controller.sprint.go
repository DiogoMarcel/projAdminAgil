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
	jsonSprint, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonSprint, &sprint)

	utilDB.ExecutarSQL(w, "INSERT INTO SPRINT (NOME,DATAINICIO,DATAFINAL) VALUES($1, $2, $3)",
		sprint.Nome, sprint.DataInicio, sprint.DataFinal)
}

func SprintAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var sprint entities.Sprint
	jsonSprint, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonSprint, &sprint)

	utilDB.ExecutarSQL(w, "UPDATE SPRINT SET NOME=$1, DATAINICIO=$2, DATAFINAL=$3 WHERE ID_SPRINT = $4",
		sprint.Nome, sprint.DataInicio, sprint.DataFinal, sprint.Id_Sprint)
}

func SprintDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var sprint entities.Sprint
	jsonSprint, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonSprint, &sprint)

	utilDB.ExecutarSQL(w, "DELETE FROM SPRINT WHERE ID_SPRINT = $1", sprint.Id_Sprint)
}

func SprintPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_SPRINT,NOME,DATAINICIO,DATAFINAL FROM SPRINT ORDER BY ID_SPRINT")
	if err == nil {
		listaSprint := []entities.Sprint{}
		for _, element := range query {
			listaSprint = append(listaSprint, entities.Sprint{
				Id_Sprint:  element["id_sprint"].(int64),
				DataInicio: element["datainicio"].(time.Time),
				DataFinal:  element["datafinal"].(time.Time),
				Nome:       element["nome"].(string),
			})
		}

		response, err := json.Marshal(listaSprint)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte(err.Error()))
		}
	}
}
