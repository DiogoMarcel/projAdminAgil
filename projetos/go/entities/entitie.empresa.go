package entities

type Empresa struct {
	Id_Empresa int64  `json:"id_empresa,string"`
	Nome       string `json:"nome"`
}
