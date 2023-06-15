package controllers

import (
	"encoding/json"
	"imports/entities"
	"imports/library"
	"imports/utilDB"
	"io"

	"net/http"

	_ "github.com/gorilla/mux"
)

func ColaboradorInserir(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var colaborador entities.Colaborador

	err := json.NewDecoder(r.Body).Decode(&colaborador)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}
	colaboradorEmail := ColaboradorEmail{User: colaborador.Usuario}
	errMail := colaboradorEmail.GenerateEmailAndPassword()

	if errMail != nil {
		library.ErrorLogger.Println(library.MESSAGE_FILE_CFGEMAIL_NOTFOUND)
		w.WriteHeader(http.StatusUnauthorized)
		io.WriteString(w, library.MESSAGE_FILE_CFGEMAIL_NOTFOUND)
	} else {
		utilDB.ExecutarSQL(w, "INSERT INTO COLABORADOR (USUARIO,SENHA,NOME,GERENCIAPESQUISA,GERENCIAUSUARIO) VALUES($1, MD5($2), $3, $4, $5)",
			colaborador.Usuario, colaboradorEmail.GetPassword(), colaborador.Nome, colaborador.GerenciaPesquisa, colaborador.GerenciaUsuario)
	}
}

func ColaboradorAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var colaborador entities.Colaborador

	err := json.NewDecoder(r.Body).Decode(&colaborador)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "UPDATE COLABORADOR "+
		" SET USUARIO = $1,"+
		" NOME = $2,"+
		" GERENCIAPESQUISA = $3,"+
		" GERENCIAUSUARIO = $4"+
		" WHERE ID_COLABORADOR = $5",
		colaborador.Usuario,
		colaborador.Nome,
		colaborador.GerenciaPesquisa,
		colaborador.GerenciaUsuario,
		colaborador.Id_Colaborador)
}

func ColaboradorDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var colaborador entities.Colaborador

	err := json.NewDecoder(r.Body).Decode(&colaborador)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

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

		err := json.NewEncoder(w).Encode(listaColaborador)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, err.Error())
		}
	}
}
