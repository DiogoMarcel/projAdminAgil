package controllers

import (
	"encoding/json"
	"imports/entities"
	"imports/utilDB"
	"io"

	"net/http"

	_ "github.com/gorilla/mux"
)

func ColaboradorInserir(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var colaborador entities.Colaborador
	jsonColaborador, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonColaborador, &colaborador)

	utilDB.ExecutarSQL(w, "INSERT INTO COLABORADOR (USUARIO,SENHA,NOME,GERENCIAPESQUISA,GERENCIAUSUARIO) VALUES($1, $2, $3, $4, $5)",
		colaborador.Usuario, colaborador.Senha, colaborador.Nome, colaborador.GerenciaPesquisa, colaborador.GerenciaUsuario)
}

func ColaboradorAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var colaborador entities.Colaborador
	jsonColaborador, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonColaborador, &colaborador)

	utilDB.ExecutarSQL(w, "UPDATE COLABORADOR "+
		" SET USUARIO = $1,"+
		" SENHA = $2,"+
		" NOME = $3,"+
		" GERENCIAPESQUISA = $4,"+
		" GERENCIAUSUARIO = $5"+
		" WHERE ID_COLABORADOR = $2",
		colaborador.Usuario,
		colaborador.Senha,
		colaborador.Nome,
		colaborador.GerenciaPesquisa,
		colaborador.GerenciaUsuario)
}

func ColaboradorDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var colaborador entities.Colaborador
	jsonColaborador, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonColaborador, &colaborador)

	utilDB.ExecutarSQL(w, "DELETE FROM COLABORADOR WHERE ID_COLABORADOR = $1", colaborador.Id_Colaborador)
}

func ColaboradorPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w,
		"SELECT ID_COLABORADOR"+
			" , USUARIO"+
			" , SENHA"+
			" , NOME"+
			" , GERENCIAPESQUISA"+
			" , GERENCIAUSUARIO"+
			" FROM COLABORADOR"+
			" ORDER BY ID_COLABORADOR")
	if err == nil {
		listaColaborador := []entities.Colaborador{}

		for _, element := range query {
			listaColaborador = append(listaColaborador, entities.Colaborador{
				Id_Colaborador:   element["id_colaborador"].(int64),
				Usuario:          element["usuario"].(string),
				Senha:            element["senha"].(string),
				Nome:             element["nome"].(string),
				GerenciaPesquisa: element["gerenciapesquisa"].(bool),
				GerenciaUsuario:  element["gerenciausuario"].(bool),
			})
		}

		response, err := json.Marshal(listaColaborador)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte(err.Error()))
		}
	}
}
