package utilDB

import (
	conexaobd "imports/conexaoBD"
	"net/http"
)

func ExecutarSQL(w http.ResponseWriter, sql string, args ...any) {
	linha := conexaobd.Db.QueryRow(sql, args...)
	if linha.Err() == nil {
		w.Write([]byte("Registro Salvo Com Sucesso!!"))
	} else {
		w.WriteHeader(400)
		w.Write([]byte("Erro no Servidor GO: " + linha.Err().Error()))
	}

}

func GetQuerySQL(w http.ResponseWriter, sql string) ([]map[string]interface{}, error) {
	rows, err := conexaobd.Db.Query(sql)
	if err == nil {
		columns, _ := rows.Columns()
		values := make([]interface{}, len(columns))
		valuePtrs := make([]interface{}, len(columns))
		var resultQuery = []map[string]interface{}{}

		for rows.Next() {
			var itemResultQuery = make(map[string]interface{})
			for i := range columns {
				valuePtrs[i] = &values[i]
			}

			rows.Scan(valuePtrs...)

			for i, col := range columns {
				itemResultQuery[col] = values[i]
			}
			resultQuery = append(resultQuery, itemResultQuery)
		}

		return resultQuery, nil
	} else {
		w.WriteHeader(400)
		w.Write([]byte("Erro no Servidor GO: " + err.Error()))
		return nil, err
	}
}
