package estruturas

import (
	"encoding/json"
	"fmt"
	conexaobd "imports/conexaoBD"
	"imports/utilDB"
	"io"
	"net/http"
)

type Cargo struct {
	Id_Cargo  int    `json:"Id_Cargo"`
	Descricao string `json:"Descricao"`
}

func (cargo *Cargo) Inserir(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonCargo, &cargo)

	sql := fmt.Sprintf("INSERT INTO CARGO (DESCRICAO) VALUES('%s')", cargo.Descricao)
	utilDB.ExecutarSQL(w, sql)
}

func (cargo *Cargo) Alterar(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonCargo, &cargo)

	sql := fmt.Sprintf("UPDATE CARGO SET DESCRICAO = '%s' WHERE ID_CARGO = %d", cargo.Descricao, cargo.Id_Cargo)
	utilDB.ExecutarSQL(w, sql)
}

func (cargo *Cargo) Deletar(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonCargo, &cargo)

	sql := fmt.Sprintf("DELETE FROM CARGO WHERE ID_CARGO = %d", cargo.Id_Cargo)
	utilDB.ExecutarSQL(w, sql)
}

func (cargo *Cargo) PegarTodos(w http.ResponseWriter, r *http.Request) {
	rows, err := conexaobd.Db.Query("SELECT ID_CARGO, DESCRICAO FROM CARGO ORDER BY ID_CARGO")
	if err == nil {
		cargo := []Cargo{}
		for rows.Next() {
			var e Cargo
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
