package estruturas

import (
	"encoding/json"
	"imports/utilDB"
	"io"
	"net/http"
)

type Cargo struct {
	Id_Cargo  int64  `json:"Id_Cargo"`
	Descricao string `json:"Descricao"`
}

func (cargo *Cargo) Inserir(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonCargo, &cargo)

	utilDB.ExecutarSQL(w, "INSERT INTO CARGO (DESCRICAO) VALUES($1)", cargo.Descricao)
}

func (cargo *Cargo) Alterar(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonCargo, &cargo)

	utilDB.ExecutarSQL(w, "UPDATE CARGO SET DESCRICAO = $1 WHERE ID_CARGO = $2", cargo.Descricao, cargo.Id_Cargo)
}

func (cargo *Cargo) Deletar(w http.ResponseWriter, r *http.Request) {
	jsonCargo, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonCargo, &cargo)

	utilDB.ExecutarSQL(w, "DELETE FROM CARGO WHERE ID_CARGO = $1", cargo.Id_Cargo)
}

func (cargo *Cargo) PegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_CARGO, DESCRICAO FROM CARGO ORDER BY ID_CARGO")
	if err == nil {
		listaCargo := []Cargo{}

		for _, element := range query {
			listaCargo = append(listaCargo, Cargo{
				Id_Cargo:  element["id_cargo"].(int64),
				Descricao: element["descricao"].(string),
			})
		}

		response, err := json.Marshal(listaCargo)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(400)
			w.Write([]byte(err.Error()))
		}
	}
}
