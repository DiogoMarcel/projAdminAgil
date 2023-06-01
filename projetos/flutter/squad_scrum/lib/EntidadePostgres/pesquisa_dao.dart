class PesquisaDAO {
  int? idPesquisa;
  String titulo;

  PesquisaDAO({this.idPesquisa, required this.titulo});

  factory PesquisaDAO.fromJson(Map<String, dynamic> json) {
    return PesquisaDAO(
      idPesquisa: json["id_pesquisa"],
      titulo: json["titulo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_pesquisa": idPesquisa ?? "",
      "titulo": titulo,
    };
  }
}
