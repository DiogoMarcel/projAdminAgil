package controllers

import (
	"encoding/json"
	"imports/entities"
	"imports/utilDB"
	"io"

	"net/http"

	_ "github.com/gorilla/mux"
)

func PesquisaInserir(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("content-Type", "application/json")
	var pesquisa entities.Pesquisa
	jsonPesquisa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonPesquisa, &pesquisa)

	utilDB.ExecutarSQL(w, "INSERT INTO PESQUISA (TITULO) VALUES($1)", pesquisa.Titulo)
}

func PesquisaAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var pesquisa entities.Pesquisa
	jsonPesquisa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonPesquisa, &pesquisa)

	utilDB.ExecutarSQL(w, "UPDATE PESQUISA SET TITULO = $1 WHERE ID_PESQUISA = $2", pesquisa.Titulo, pesquisa.Id_Pesquisa)
}

func PesquisaDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var pesquisa entities.Pesquisa
	jsonPesquisa, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonPesquisa, &pesquisa)

	utilDB.ExecutarSQL(w, "DELETE FROM PESQUISA WHERE ID_PESQUISA = $1", pesquisa.Id_Pesquisa)
}

func PesquisaPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w, "SELECT ID_PESQUISA, TITULO FROM PESQUISA ORDER BY ID_PESQUISA")
	if err == nil {
		listaPesquisa := []entities.Pesquisa{}
		for _, element := range query {
			listaPesquisa = append(listaPesquisa, entities.Pesquisa{
				Id_Pesquisa: element["id_pesquisa"].(int64),
				Titulo:      element["titulo"].(string),
			})
		}

		response, err := json.Marshal(listaPesquisa)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte(err.Error()))
		}
	}
}
