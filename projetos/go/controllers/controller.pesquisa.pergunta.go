package controllers

import (
	"database/sql"
	"encoding/json"
	conexaobd "imports/conexaoBD"
	"imports/entities"
	"imports/utilDB"
	"io"
	"strconv"

	"net/http"

	_ "github.com/gorilla/mux"
)

func PesquisaPerguntaInserir(w http.ResponseWriter, r *http.Request) {
	var err error
	var tx *sql.Tx

	w.Header().Set("content-Type", "application/json")
	var pesquisaPergunta entities.PesquisaPergunta

	err = json.NewDecoder(r.Body).Decode(&pesquisaPergunta)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	tx, err = conexaobd.Db.Begin()
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte("Erro no Servidor GO: " + err.Error()))
	}

	for _, element := range pesquisaPergunta.IdPesquisa {
		tx.Exec("INSERT INTO PESQUISA_PERGUNTA ("+
			"PERGUNTA,VALORFINAL,VALORINICIAL,"+
			"TIPORESPOSTA,TAMANHOTOTAL,"+
			"IDPESQUISA,OBRIGATORIA) VALUES($1, $2, $3, $4, $5, $6, $7)",
			pesquisaPergunta.Pergunta, pesquisaPergunta.ValorFinal, pesquisaPergunta.ValorInicial,
			pesquisaPergunta.TipoResposta, pesquisaPergunta.TamanhoTotal,
			element, pesquisaPergunta.Obrigatoria)
	}

	err = tx.Commit()
	if err == nil {
		json.NewEncoder(w).Encode("Registro Salvo Com Sucesso!!")
	} else {
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte("Erro no Servidor GO: " + err.Error()))
			err = tx.Rollback()
			if err != nil {
				w.WriteHeader(http.StatusBadRequest)
				w.Write([]byte("Erro no Servidor GO: Rollback" + err.Error()))
			}
		}
	}
}

func PesquisaPerguntaAlterar(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("content-Type", "application/json")
	var pesquisaPergunta entities.PesquisaPergunta

	err := json.NewDecoder(r.Body).Decode(&pesquisaPergunta)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

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

	err := json.NewDecoder(r.Body).Decode(&pesquisaPergunta)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		io.WriteString(w, err.Error())
	}

	utilDB.ExecutarSQL(w, "DELETE FROM PESQUISAPERGUNTA WHERE ID_PESQUISAPERGUNTA = $1", pesquisaPergunta.Id_PesquisaPergunta)
}

func PesquisaPerguntaPegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w,
		" SELECT ID_PESQUISAPERGUNTA"+
			"  , PERGUNTA"+
			"  , COALESCE(VALORFINAL,0) VALORFINAL"+
			"  , COALESCE(VALORINICIAL,0) VALORINICIAL"+
			"  , COALESCE(TAMANHOTOTAL,0) TAMANHOTOTAL"+
			"  , IDPESQUISA"+
			"  , OBRIGATORIA "+
			"  , CASE WHEN UPPER(TIPORESPOSTA) = 'D' THEN 'Decimal' "+
			"         WHEN UPPER(TIPORESPOSTA) = 'S' THEN 'String' "+
			"         ELSE 'Boolean' "+
			"         END TIPORESPOSTA"+
			"  FROM PESQUISA_PERGUNTA"+
			" ORDER BY ID_PESQUISAPERGUNTA")
	if err == nil {
		listaPesquisaPergunta := []entities.PesquisaPergunta{}
		for _, element := range query {
			valorFinal, _ := strconv.ParseFloat(string(element["valorfinal"].([]uint8)), 64)
			valorInicial, _ := strconv.ParseFloat(string(element["valorinicial"].([]uint8)), 64)
			numeros := []int64{element["idpesquisa"].(int64)}

			listaPesquisaPergunta = append(listaPesquisaPergunta, entities.PesquisaPergunta{
				Id_PesquisaPergunta: element["id_pesquisapergunta"].(int64),
				Pergunta:            element["pergunta"].(string),
				ValorFinal:          valorFinal,
				ValorInicial:        valorInicial,
				TipoResposta:        element["tiporesposta"].(string),
				TamanhoTotal:        element["tamanhototal"].(int64),
				Obrigatoria:         element["obrigatoria"].(bool),
				IdPesquisa:          numeros,
			})
		}

		err := json.NewEncoder(w).Encode(listaPesquisaPergunta)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			io.WriteString(w, err.Error())
		}
	}
}
