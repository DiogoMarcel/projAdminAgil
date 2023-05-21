package crudbd

import (
	"encoding/json"
	conexaobd "imports/conexaoBD"
	"imports/estruturas"
	"io"
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
		w.WriteHeader(400)
		w.Write([]byte(linha.Err().Error()))
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
		w.WriteHeader(400)
		w.Write([]byte(linha.Err().Error()))
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
		w.WriteHeader(400)
		w.Write([]byte(linha.Err().Error()))
	}
}

func PegarTodosCargos(w http.ResponseWriter, r *http.Request) {
	rows, err := conexaobd.Db.Query("SELECT ID_CARGO, DESCRICAO FROM CARGO ORDER BY ID_CARGO")
	if err == nil {
		cargo := []estruturas.Cargo{}
		for rows.Next() {
			var e estruturas.Cargo
			err := rows.Scan(&e.Id_Cargo, &e.Descricao)
			if err == nil {
				cargo = append(cargo, e)
			} else {
				w.WriteHeader(400)
				w.Write([]byte(err.Error()))
			}
		}

		response, err := json.Marshal(cargo)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(400)
			w.Write([]byte(err.Error()))
		}
	} else {
		w.WriteHeader(400)
		w.Write([]byte(err.Error()))
	}
}
