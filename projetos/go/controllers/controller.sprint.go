package controllers

import (
	"database/sql"
	"encoding/json"
	conexaobd "imports/conexaoBD"
	"imports/entities"
	"imports/utilDB"
	"io"
	"net/http"
	"strconv"
	"time"

	_ "github.com/gorilla/mux"
)

func SprintInserir(w http.ResponseWriter, r *http.Request) {
	var err error
	var tx *sql.Tx

	w.Header().Set("content-Type", "application/json")
	var sprint entities.Sprint

	err = json.NewDecoder(r.Body).Decode(&sprint)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	tx, err = conexaobd.Db.Begin()
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte("Erro no Servidor GO: " + err.Error()))
	}

	tx.QueryRow("INSERT INTO SPRINT (NOME,DATAINICIO,DATAFINAL) VALUES($1, $2, $3) RETURNING ID_SPRINT",
		sprint.Nome, sprint.DataInicio, sprint.DataFinal).Scan(&sprint.Id_Sprint)

	tx.Exec("INSERT INTO SPRINT_PESQUISA (IDPESQUISA,IDSPRINT) VALUES($1,$2)",
		sprint.Pesquisa.Id_Pesquisa, sprint.Id_Sprint)

	if err == nil {
		err = tx.Commit()
		if err == nil {
			json.NewEncoder(w).Encode("Registro Salvo Com Sucesso!!")
		} else {
			tx.Rollback()
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, "Erro ao Commitar a Transacao no Servidor GO: "+err.Error())
		}
	}
}

func SprintAlterar(w http.ResponseWriter, r *http.Request) {
	var err error
	var tx *sql.Tx

	w.Header().Set("content-Type", "application/json")
	var sprint entities.Sprint

	err = json.NewDecoder(r.Body).Decode(&sprint)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	tx, err = conexaobd.Db.Begin()
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte("Erro no Servidor GO: " + err.Error()))
	}

	tx.Exec("UPDATE SPRINT SET NOME=$1, DATAINICIO=$2, DATAFINAL=$3 WHERE ID_SPRINT = $4",
		sprint.Nome, sprint.DataInicio, sprint.DataFinal, sprint.Id_Sprint)

	tx.Exec("DELETE FROM SPRINT_PESQUISA WHERE IDSPRINT = $1",
		sprint.Id_Sprint)

	tx.Exec("INSERT INTO SPRINT_PESQUISA (IDPESQUISA,IDSPRINT) VALUES($1,$2)",
		sprint.Pesquisa.Id_Pesquisa, sprint.Id_Sprint)

	if err == nil {
		err = tx.Commit()
		if err == nil {
			json.NewEncoder(w).Encode("Registro Salvo Com Sucesso!!")
		} else {
			tx.Rollback()
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, "Erro ao Commitar a Transacao no Servidor GO: "+err.Error())
		}
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
		"  SELECT S.ID_SPRINT"+
			"         , S.NOME"+
			"         , S.DATAINICIO"+
			"         , S.DATAFINAL"+
			"         , COALESCE(P.ID_PESQUISA,0) ID_PESQUISA"+
			"         , COALESCE(P.TITULO,'') TITULO"+
			"      FROM SPRINT S "+
			" LEFT JOIN SPRINT_PESQUISA SP "+
			"        ON S.ID_SPRINT = SP.IDSPRINT "+
			" LEFT JOIN PESQUISA P "+
			"        ON SP.IDPESQUISA = P.ID_PESQUISA "+
			" ORDER BY ID_SPRINT")
	if err == nil {
		listaSprint := []entities.Sprint{}
		for _, element := range query {
			listaSprint = append(listaSprint, entities.Sprint{
				Id_Sprint:  element["id_sprint"].(int64),
				DataInicio: element["datainicio"].(time.Time),
				DataFinal:  element["datafinal"].(time.Time),
				Nome:       element["nome"].(string),
				Pesquisa: &entities.Pesquisa{
					Id_Pesquisa: strconv.FormatInt(element["id_pesquisa"].(int64), 10),
					Titulo:      element["titulo"].(string),
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
