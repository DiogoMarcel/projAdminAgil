package entities

type Equipe struct {
	Id_Equipe int64  `json:"id_equipe,string,omitempty"`
	Nome      string `json:"nome"`
}
