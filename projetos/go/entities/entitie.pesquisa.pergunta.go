package entities

type PesquisaPergunta struct {
	Id_PesquisaPergunta int64   `json:"id_pesquisa_pergunta,string,omitempty"`
	Pergunta            string  `json:"pergunta"`
	ValorInicial        float64 `json:"valor_inicial"`
	ValorFinal          float64 `json:"valor_final"`
	TipoResposta        string  `json:"tipo_resposta"`
	TamanhoTotal        int64   `json:"tamanho_total"`
	Obrigatoria         bool    `json:"obrigatoria"`
	IdPesquisa          int64   `json:"idpesquisa"`
}
