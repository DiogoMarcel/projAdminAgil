class PesquisaPerguntaDAO {
  int? idPesquisaPergunta;
  String pergunta;
  double valorFinal;
  double valorInicial;
  String tipoResposta;
  int tamanhoTotal;
  int idPesquisa;
  bool obrigatoria;

  PesquisaPerguntaDAO(
      {this.idPesquisaPergunta,
      required this.pergunta,
      required this.valorFinal,
      required this.valorInicial,
      required this.tipoResposta,
      required this.tamanhoTotal,
      required this.idPesquisa,
      required this.obrigatoria});

  factory PesquisaPerguntaDAO.fromJson(Map<String, dynamic> json) {
    return PesquisaPerguntaDAO(
      idPesquisaPergunta: int.parse(json['id_pesquisapergunta']),
      pergunta: json['pergunta'],
      valorFinal: double.parse(json['valorfinal'].toString()),
      valorInicial: double.parse(json['valorinicial'].toString()),
      tipoResposta: json['tiporesposta'],
      tamanhoTotal: json['tamanhototal'],
      idPesquisa: json['idpesquisa'],
      obrigatoria: json['obrigatoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pesquisapergunta': idPesquisaPergunta.toString(),
      'pergunta': pergunta,
      'valorfinal': valorFinal,
      'valorinicial': valorInicial,
      'tiporesposta': tipoResposta,
      'tamanhototal': tamanhoTotal,
      'idpesquisa': idPesquisa,
      'obrigatoria': obrigatoria,
    };
  }
}
