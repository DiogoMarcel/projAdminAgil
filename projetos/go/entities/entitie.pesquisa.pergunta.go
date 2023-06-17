package entities

type PesquisaPergunta struct {
	Id_PesquisaPergunta int64   `json:"id_pesquisapergunta,string,omitempty"`
	Pergunta            string  `json:"pergunta"`
	ValorInicial        float64 `json:"valorinicial"`
	ValorFinal          float64 `json:"valorfinal"`
	TipoResposta        string  `json:"tiporesposta"`
	TamanhoTotal        int64   `json:"tamanhototal"`
	Obrigatoria         bool    `json:"obrigatoria"`
	IdPesquisa          int64   `json:"idpesquisa"`
}
