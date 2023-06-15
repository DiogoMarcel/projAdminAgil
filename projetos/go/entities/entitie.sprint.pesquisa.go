package entities

type SprintPesquisa struct {
	Id_SprintPesquisa int64 `json:"id_sprintpesquisa,string"`
	IdPesquisa        int64 `json:"idpesquisa"`
	IdSprint          int64 `json:"idsprint"`
}
