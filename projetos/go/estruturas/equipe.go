package estruturas

import (
	"encoding/json"
	"fmt"
	conexaobd "imports/conexaoBD"
	"imports/utilDB"
	"io"
	"net/http"
)

type Equipe struct {
	Id_Equipe int    `json:"Id_Equipe"`
	Nome      string `json:"Nome"`
}

func (equipe *Equipe) Inserir(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEquipe, &equipe)

	sql := fmt.Sprintf("INSERT INTO EQUIPE (NOME) VALUES('%s')", equipe.Nome)
	utilDB.ExecutarSQL(w, sql)
}

func (equipe *Equipe) Alterar(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEquipe, &equipe)

	sql := fmt.Sprintf("UPDATE EQUIPE SET NOME = '%s' WHERE ID_EQUIPE = %d", equipe.Nome, equipe.Id_Equipe)
	utilDB.ExecutarSQL(w, sql)
}

func (equipe *Equipe) Deletar(w http.ResponseWriter, r *http.Request) {
	jsonEquipe, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEquipe, &equipe)

	sql := fmt.Sprintf("DELETE FROM EQUIPE WHERE ID_EQUIPE = %d", equipe.Id_Equipe)
	utilDB.ExecutarSQL(w, sql)
}

func (equipe *Equipe) PegarTodos(w http.ResponseWriter, r *http.Request) {
	rows, err := conexaobd.Db.Query("SELECT ID_EQUIPE, NOME FROM EQUIPE ORDER BY ID_EQUIPE")
	if err == nil {
		equipe := []Equipe{}
		for rows.Next() {
			var e Equipe
			err := rows.Scan(&e.Id_Equipe, &e.Nome)
			if err == nil {
				equipe = append(equipe, e)
			} else {
				w.WriteHeader(400)
				w.Write([]byte(err.Error()))
			}
		}

		response, err := json.Marshal(equipe)
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
