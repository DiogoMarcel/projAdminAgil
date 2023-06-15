package entities

type Pesquisa struct {
	Id_Pesquisa int64  `json:"id_pesquisa,string,omitempty"`
	Titulo      string `json:"titulo"`
}
