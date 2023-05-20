package crudbd

import (
	"encoding/json"
	conexaobd "imports/conexaoBD"
	"imports/estruturas"
	"io"
	"log"
	"net/http"
)

func InserirEquipe(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)
	var equipe = estruturas.Equipe{}

	json.Unmarshal(jsonEquipe, &equipe)

	linha := conexaobd.Db.QueryRow("INSERT INTO EQUIPE (NOME) VALUES($1)", equipe.Nome)
	if linha.Err() == nil {
		w.Write([]byte("Registro Salvo Com Sucesso!!"))
	} else {
		w.Write([]byte("Fudeu Piá " + linha.Err().Error()))
	}
}

func AlterarEquipe(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)
	var equipe = estruturas.Equipe{}

	json.Unmarshal(jsonEquipe, &equipe)

	linha := conexaobd.Db.QueryRow("UPDATE EQUIPE SET NOME = $1 WHERE ID_EQUIPE = $2", equipe.Nome, equipe.Id_Equipe)
	if linha.Err() == nil {
		w.Write([]byte("Registro Alterado com Sucesso!!"))
	} else {
		w.Write([]byte("Fudeu Piá " + linha.Err().Error()))
	}
}

func DeletarEquipe(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)
	var equipe = estruturas.Equipe{}

	json.Unmarshal(jsonEquipe, &equipe)

	linha := conexaobd.Db.QueryRow("DELETE FROM EQUIPE WHERE ID_EQUIPE = $1", equipe.Id_Equipe)
	if linha.Err() == nil {
		w.Write([]byte("Registro Removido com Sucesso!!"))
	} else {
		w.Write([]byte("Fudeu Piá " + linha.Err().Error()))
	}
}

func PegarTodasEquipes(w http.ResponseWriter, r *http.Request) {
	rows, _ := conexaobd.Db.Query("SELECT ID_EQUIPE, NOME FROM EQUIPE ORDER BY ID_EQUIPE")
	equipe := []estruturas.Equipe{}
	for rows.Next() {
		var e estruturas.Equipe
		if err := rows.Scan(&e.Id_Equipe, &e.Nome); err != nil {
			log.Fatal(err.Error())
		}
		equipe = append(equipe, e)
	}

	response, _ := json.Marshal(equipe)
	w.Write(response)
}
