package controllers

import (
	"encoding/json"
	"fmt"
	"imports/entities"
	"imports/utilDB"
	"io"
	"strconv"

	"net/http"

	_ "github.com/gorilla/mux"
)

func PesquisaPerguntaInserir(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var pesquisaPergunta entities.PesquisaPergunta
	jsonPesquisaPergunta, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonPesquisaPergunta, &pesquisaPergunta)

	utilDB.ExecutarSQL(w, "INSERT INTO PESQUISAPERGUNTA ("+
		"PERGUNTA,VALORFINAL,VALORINICIAL,"+
		"TIPORESPOSTA,TAMANHOTOTAL,"+
		"IDPESQUISA,OBRIGATORIA) VALUES($1)",
		pesquisaPergunta.Pergunta, pesquisaPergunta.ValorFinal, pesquisaPergunta.ValorInicial,
		pesquisaPergunta.TipoResposta, pesquisaPergunta.TamanhoTotal,
		pesquisaPergunta.IdPesquisa, pesquisaPergunta.Obrigatoria)
}

func PesquisaPerguntaAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var pesquisaPergunta entities.PesquisaPergunta
	jsonPesquisaPergunta, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonPesquisaPergunta, &pesquisaPergunta)

	utilDB.ExecutarSQL(w, "UPDATE PESQUISAPERGUNTA"+
		" SET PERGUNTA = $1,"+
		" VALORFINAL = $2,"+
		" VALORINICIAL = $3,"+
		" TIPORESPOSTA = $4,"+
		" TAMANHOTOTAL = $5,"+
		" IDPESQUISA = $6,"+
		" OBRIGATORIA = $7"+
		" WHERE ID_PESQUISAPERGUNTA = $8",
		pesquisaPergunta.Pergunta, pesquisaPergunta.ValorFinal, pesquisaPergunta.ValorInicial,
		pesquisaPergunta.TipoResposta, pesquisaPergunta.TamanhoTotal,
		pesquisaPergunta.IdPesquisa, pesquisaPergunta.Obrigatoria,
		pesquisaPergunta.Id_PesquisaPergunta)
}

func PesquisaPerguntaDeletar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var pesquisaPergunta entities.PesquisaPergunta
	jsonPesquisaPergunta, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonPesquisaPergunta, &pesquisaPergunta)

	utilDB.ExecutarSQL(w, "DELETE FROM PESQUISAPERGUNTA WHERE ID_PESQUISAPERGUNTA = $1", pesquisaPergunta.Id_PesquisaPergunta)
}

func PesquisaPerguntaPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w,
		"SELECT  ID_PESQUISAPERGUNTA"+
			"  , PERGUNTA"+
			"  , 3.14159::DECIMAL VALORFINAL"+
			"  , CAST(COALESCE(VALORINICIAL,0.0) AS NUMERIC(5,2)) VALORINICIAL"+
			"  , TIPORESPOSTA"+
			"  , COALESCE(TAMANHOTOTAL,0) TAMANHOTOTAL"+
			"  , IDPESQUISA"+
			"  , OBRIGATORIA "+
			"  FROM PESQUISA_PERGUNTA"+
			" ORDER BY ID_PESQUISAPERGUNTA")
	if err == nil {
		listaPesquisaPergunta := []entities.PesquisaPergunta{}
		for _, element := range query {
			valorFinal := fmt.Sprintf("%s", element["valorfinal"])
			valorInicial := fmt.Sprintf("%s", element["valorinicial"])
			tipoResposta := fmt.Sprintf("%s", element["tiporesposta"])

			valorFinalFloat64, _ := strconv.ParseFloat(valorFinal, 64)
			valorInicialFloat64, _ := strconv.ParseFloat(valorInicial, 64)

			listaPesquisaPergunta = append(listaPesquisaPergunta, entities.PesquisaPergunta{
				Id_PesquisaPergunta: element["id_pesquisapergunta"].(int64),
				Pergunta:            element["pergunta"].(string),
				ValorFinal:          valorFinalFloat64,
				ValorInicial:        valorInicialFloat64,
				TipoResposta:        tipoResposta,
				TamanhoTotal:        element["tamanhototal"].(int64),
				Obrigatoria:         element["obrigatoria"].(bool),
				IdPesquisa:          element["idpesquisa"].(int64),
			})
		}

		response, err := json.Marshal(listaPesquisaPergunta)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte(err.Error()))
		}
	}
}
