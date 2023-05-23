package estruturas

import (
	"encoding/json"
	"imports/utilDB"
	"io"
	"net/http"
)

type Equipe struct {
	Id_Equipe int64  `json:"Id_Equipe"`
	Nome      string `json:"Nome"`
}

func (equipe *Equipe) Inserir(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEquipe, &equipe)

	utilDB.ExecutarSQL(w, "INSERT INTO EQUIPE (NOME) VALUES($1)", equipe.Nome)
}

func (equipe *Equipe) Alterar(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEquipe, &equipe)

	utilDB.ExecutarSQL(w, "UPDATE EQUIPE SET NOME = $1 WHERE ID_EQUIPE = $2", equipe.Nome, equipe.Id_Equipe)
}

func (equipe *Equipe) Deletar(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEquipe, &equipe)

	utilDB.ExecutarSQL(w, "DELETE FROM EQUIPE WHERE ID_EQUIPE = $1", equipe.Id_Equipe)
}

func (equipe *Equipe) PegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_EQUIPE, NOME FROM EQUIPE ORDER BY ID_EQUIPE")
	if err == nil {
		listaEquipe := []Equipe{}

		for _, element := range query {
			listaEquipe = append(listaEquipe, Equipe{
				Id_Equipe: element["id_equipe"].(int64),
				Nome:      element["nome"].(string),
			})
		}

		response, err := json.Marshal(listaEquipe)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(400)
			w.Write([]byte(err.Error()))
		}
	}
}
