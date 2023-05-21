package crudbd

import (
	"encoding/json"
	conexaobd "imports/conexaoBD"
	"imports/estruturas"
	"io"
	"log"
	"net/http"
)

func InserirCargo(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)
	var cargo = estruturas.Cargo{}

	json.Unmarshal(jsonCargo, &cargo)

	linha := conexaobd.Db.QueryRow("INSERT INTO CARGO (DESCRICAO) VALUES($1)", cargo.Descricao)
	if linha.Err() == nil {
		w.Write([]byte("Registro Salvo Com Sucesso!!"))
	} else {
		w.Write([]byte("Fudeu Piá " + linha.Err().Error()))
	}
}

func AlterarCargo(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)
	var cargo = estruturas.Cargo{}

	json.Unmarshal(jsonCargo, &cargo)

	linha := conexaobd.Db.QueryRow("UPDATE CARGO SET DESCRICAO = $1 WHERE ID_CARGO = $2", cargo.Descricao, cargo.Id_Cargo)
	if linha.Err() == nil {
		w.Write([]byte("Registro Alterado com Sucesso!!"))
	} else {
		w.Write([]byte("Fudeu Piá " + linha.Err().Error()))
	}
}

func DeletarCargo(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)
	var cargo = estruturas.Cargo{}

	json.Unmarshal(jsonCargo, &cargo)

	linha := conexaobd.Db.QueryRow("DELETE FROM CARGO WHERE ID_CARGO = $1", cargo.Id_Cargo)
	if linha.Err() == nil {
		w.Write([]byte("Registro Removido com Sucesso!!"))
	} else {
		w.Write([]byte("Fudeu Piá " + linha.Err().Error()))
	}
}

func PegarTodosCargos(w http.ResponseWriter, r *http.Request) {
	rows, _ := conexaobd.Db.Query("SELECT ID_CARGO, DESCRICAO FROM CARGO ORDER BY ID_CARGO")
	cargo := []estruturas.Cargo{}
	for rows.Next() {
		var e estruturas.Cargo
		if err := rows.Scan(&e.Id_Cargo, &e.Descricao); err != nil {
			log.Fatal(err.Error())
		}
		cargo = append(cargo, e)
	}

	response, _ := json.Marshal(cargo)
	w.Write(response)
}
