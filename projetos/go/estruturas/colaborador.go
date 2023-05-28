package estruturas

import (
	"encoding/json"
	"imports/utilDB"
	"io"
	"net/http"
)

type Colaborador struct {
	Id_Colaborador   int64  `json:"Id_Colaborador"`
	Usuario          string `json:"Usuario"`
	Senha            string `json:"Senha"`
	Apelido          string `json:"Apelido"`
	GerenciaPesquisa bool   `json:"GerenciaPesquisa"`
	GerenciaUsuario  bool   `json:"GerenciaUsuario"`
}

func (colaborador *Colaborador) Inserir(w http.ResponseWriter, r *http.Request) {
	jsonColaborador, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonColaborador, &colaborador)

	utilDB.ExecutarSQL(w, "INSERT INTO COLABORADOR (USUARIO,SENHA,APELIDO,GERENCIAPESQUISA,GERENCIAUSUARIO) VALUES($1, $2, $3, $4, $5)",
		colaborador.Usuario, colaborador.Senha, colaborador.Apelido, colaborador.GerenciaPesquisa, colaborador.GerenciaUsuario)
}

func (colaborador *Colaborador) Alterar(w http.ResponseWriter, r *http.Request) {
	jsonColaborador, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonColaborador, &colaborador)

	utilDB.ExecutarSQL(w, "UPDATE COLABORADOR "+
		" SET USUARIO = $1,"+
		" SENHA = $2,"+
		" APELIDO = $3,"+
		" GERENCIAPESQUISA = $4,"+
		" GERENCIAUSUARIO = $5"+
		" WHERE ID_CARGO = $2",
		colaborador.Usuario,
		colaborador.Senha,
		colaborador.Apelido,
		colaborador.GerenciaPesquisa,
		colaborador.GerenciaUsuario)
}

func (colaborador *Colaborador) Deletar(w http.ResponseWriter, r *http.Request) {
	jsonColaborador, _ := io.ReadAll(r.Body)

	json.Unmarshal(jsonColaborador, &colaborador)

	utilDB.ExecutarSQL(w, "DELETE FROM COLABORADOR WHERE ID_COLABORADOR = $1", colaborador.Id_Colaborador)
}

func (colaborador *Colaborador) PegarTodos(w http.ResponseWriter, r *http.Request) {
	query, err := utilDB.GetQuerySQL(w,
		"SELECT ID_COLABORADOR"+
			" , USUARIO"+
			" , SENHA"+
			" , APELIDO"+
			" , GERENCIAPESQUISA"+
			" , GERENCIAUSUARIO"+
			" FROM COLABORADOR"+
			" ORDER BY ID_COLABORADOR")
	if err == nil {
		listaColaborador := []Colaborador{}

		for _, element := range query {
			listaColaborador = append(listaColaborador, Colaborador{
				Id_Colaborador:   element["id_colaborador"].(int64),
				Usuario:          element["usuario"].(string),
				Senha:            element["senha"].(string),
				Apelido:          element["apelido"].(string),
				GerenciaPesquisa: element["gerenciapesquisa"].(bool),
				GerenciaUsuario:  element["gerenciausuario"].(bool),
			})
		}

		response, err := json.Marshal(listaColaborador)
		if err == nil {
			w.Write(response)
		} else {
			w.WriteHeader(400)
			w.Write([]byte(err.Error()))
		}
	}
}
