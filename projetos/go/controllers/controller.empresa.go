package controllers

import (
	"encoding/json"
	"imports/entities"
	"imports/utilDB"
	"io"

	"net/http"

	_ "github.com/gorilla/mux"
)

func EmpresaInserir(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var empresa entities.Empresa
	jsonEmpresa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEmpresa, &empresa)

	utilDB.ExecutarSQL(w, "INSERT INTO EMPRESA (NOME) VALUES($1)", empresa.Nome)
}

func EmpresaAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var empresa entities.Empresa
	jsonEmpresa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEmpresa, &empresa)

	utilDB.ExecutarSQL(w, "UPDATE EMPRESA SET NOME = $1 WHERE ID_EMPRESA = $2", empresa.Nome, empresa.Id_Empresa)
}

func EmpresaDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var empresa entities.Empresa
	jsonEmpresa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonEmpresa, &empresa)

	utilDB.ExecutarSQL(w, "DELETE FROM EMPRESA WHERE ID_EMPRESA = $1", empresa.Id_Empresa)
}

func EmpresaPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_EMPRESA, NOME FROM EMPRESA ORDER BY ID_EMPRESA")
	if err == nil {
		listaEmpresa := []entities.Empresa{}

		for _, element := range query {
			listaEmpresa = append(listaEmpresa, entities.Empresa{
				Id_Empresa: element["id_empresa"].(int64),
				Nome:       element["nome"].(string),
			})
		}

		response, err := json.Marshal(listaEmpresa)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte(err.Error()))
		}
	}
}
