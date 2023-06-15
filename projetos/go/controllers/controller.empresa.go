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

	err := json.NewDecoder(r.Body).Decode(&empresa)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "INSERT INTO EMPRESA (NOME) VALUES($1)", empresa.Nome)
}

func EmpresaAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var empresa entities.Empresa

	err := json.NewDecoder(r.Body).Decode(&empresa)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "UPDATE EMPRESA SET NOME = $1 WHERE ID_EMPRESA = $2", empresa.Nome, empresa.Id_Empresa)
}

func EmpresaDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var empresa entities.Empresa

	err := json.NewDecoder(r.Body).Decode(&empresa)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

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

		json.NewEncoder(w).Encode(listaEmpresa)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, err.Error())
		}
	}
}
