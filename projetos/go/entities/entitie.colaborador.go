package entities

type Colaborador struct {
	Id_Colaborador   int64  `json:"id_colaborador,string,omitempty"`
	Usuario          string `json:"usuario"`
	Senha            string `json:"senha"`
	Nome             string `json:"nome"`
	GerenciaPesquisa bool   `json:"gerenciapesquisa"`
	GerenciaUsuario  bool   `json:"gerenciausuario"`
}
