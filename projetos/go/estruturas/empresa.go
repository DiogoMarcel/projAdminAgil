package estruturas

import (
	"encoding/json"
	"imports/utilDB"
	"io"
	"net/http"
)

type Empresa struct {
	Id_Empresa int64  `json:"id_empresa"`
	Nome       string `json:"nome"`
}

func (empresa *Empresa) Inserir(w http.ResponseWriter, r *http.Request) {
	jsonEmpresa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEmpresa, &empresa)

	utilDB.ExecutarSQL(w, "INSERT INTO EMPRESA (NOME) VALUES($1)", empresa.Nome)
}

func (empresa *Empresa) Alterar(w http.ResponseWriter, r *http.Request) {
	jsonEmpresa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEmpresa, &empresa)

	utilDB.ExecutarSQL(w, "UPDATE EMPRESA SET NOME = $1 WHERE ID_EMPRESA = $2", empresa.Nome, empresa.Id_Empresa)
}

func (empresa *Empresa) Deletar(w http.ResponseWriter, r *http.Request) {
	jsonEmpresa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEmpresa, &empresa)

	utilDB.ExecutarSQL(w, "DELETE FROM EMPRESA WHERE ID_EMPRESA = $1", empresa.Id_Empresa)
}

func (empresa *Empresa) PegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_EMPRESA, NOME FROM EMPRESA ORDER BY ID_EMPRESA")
	if err == nil {
		listaEmpresa := []Empresa{}

		for _, element := range query {
			listaEmpresa = append(listaEmpresa, Empresa{
				Id_Empresa: element["id_empresa"].(int64),
				Nome:       element["nome"].(string),
			})
		}

		response, err := json.Marshal(listaEmpresa)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(400)
			w.Write([]byte(err.Error()))
		}
	}
}
