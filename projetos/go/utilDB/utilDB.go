package utilDB

import (
	conexaobd "imports/conexaoBD"
	"net/http"
)

func ExecutarSQL(w http.ResponseWriter, sql string) {
	linha := conexaobd.Db.QueryRow(sql)
	if linha.Err() == nil {
		w.Write([]byte("Registro Salvo Com Sucesso!!"))
	} else {
		w.WriteHeader(400)
		w.Write([]byte("Erro no Servidor GO: " + linha.Err().Error()))
	}

}
