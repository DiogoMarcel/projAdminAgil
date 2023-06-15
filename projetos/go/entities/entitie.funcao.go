package entities

type Funcao struct {
	Id_Funcao int64  `json:"id_funcao,string,omitempty"`
	Descricao string `json:"descricao"`
}
