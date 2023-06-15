package entities

type Empresa struct {
	Id_Empresa int64  `json:"id_empresa,string,omitempty"`
	Nome       string `json:"nome"`
}
