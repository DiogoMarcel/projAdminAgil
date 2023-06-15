package entities

type Cargo struct {
	Id_Cargo  int64  `json:"id_cargo,string,omitempty"`
	Descricao string `json:"descricao"`
}
