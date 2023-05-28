package estruturas

import (
	"encoding/json"
	"imports/utilDB"
	"io"
	"net/http"
)

type Funcao struct {
	Id_Funcao int64  `json:"Id_Funcao"`
	Descricao string `json:"Descricao"`
}

func (funcao *Funcao) Inserir(w http.ResponseWriter, r *http.Request) {
	jsonFuncao, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonFuncao, &funcao)

	utilDB.ExecutarSQL(w, "INSERT INTO FUNCAO (DESCRICAO) VALUES($1)", funcao.Descricao)
}

func (funcao *Funcao) Alterar(w http.ResponseWriter, r *http.Request) {
	jsonFuncao, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonFuncao, &funcao)

	utilDB.ExecutarSQL(w, "UPDATE FUNCAO SET DESCRICAO = $1 WHERE ID_FUNCAO = $2", funcao.Descricao, funcao.Id_Funcao)
}

func (equipe *Funcao) Deletar(w http.ResponseWriter, r *http.Request) {
	jsonFuncao, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonFuncao, &equipe)

	utilDB.ExecutarSQL(w, "DELETE FROM FUNCAO WHERE ID_FUNCAO = $1", equipe.Id_Funcao)
}

func (equipe *Funcao) PegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_FUNCAO, DESCRICAO FROM FUNCAO ORDER BY ID_FUNCAO")
	if err == nil {
		listaFuncao := []Funcao{}

		for _, element := range query {
			listaFuncao = append(listaFuncao, Funcao{
				Id_Funcao: element["id_funcao"].(int64),
				Descricao: element["descricao"].(string),
			})
		}

		response, err := json.Marshal(listaFuncao)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(400)
			w.Write([]byte(err.Error()))
		}
	}
}
