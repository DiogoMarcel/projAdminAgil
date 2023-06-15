class ColaboradorDAO {
  int? idColaborador;
  String usuario;
  String nome;
  bool gerenciapesquisa;
  bool gerenciausuario;

  ColaboradorDAO(
      {this.idColaborador,
      required this.usuario,
      required this.nome,
      required this.gerenciapesquisa,
      required this.gerenciausuario});

  factory ColaboradorDAO.fromJson(Map<String, dynamic> json) {
    return ColaboradorDAO(
      idColaborador: int.parse(json["id_colaborador"]),
      usuario: json["usuario"],
      nome: json["nome"],
      gerenciapesquisa: json["gerenciapesquisa"],
      gerenciausuario: json["gerenciausuario"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_colaborador": idColaborador.toString(),
      "usuario": usuario,
      "nome": nome,
      "gerenciapesquisa": gerenciapesquisa,
      "gerenciausuario": gerenciausuario,
    };
  }
}
