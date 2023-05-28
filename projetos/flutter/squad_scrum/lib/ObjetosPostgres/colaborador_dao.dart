class ColaboradorDAO {
  int? idColaborador;
  String usuario;
  String senha;
  String apelido;
  bool gerenciapesquisa;
  bool gerenciausuario;

  ColaboradorDAO(
      {this.idColaborador,
      required this.usuario,
      required this.senha,
      required this.apelido,
      required this.gerenciapesquisa,
      required this.gerenciausuario});

  factory ColaboradorDAO.fromJson(Map<String, dynamic> json) {
    return ColaboradorDAO(
      idColaborador: json["Id_Colaborador"],
      usuario: json["Usuario"],
      senha: json["Senha"],
      apelido: json["Apelido"],
      gerenciapesquisa: json["GerenciaPesquisa"],
      gerenciausuario: json["GerenciaUsuario"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id_Colaborador": idColaborador ?? "",
      "Usuario": usuario,
      "Senha": senha,
      "Apelido": apelido,
      "GerenciaPesquisa": gerenciapesquisa,
      "GerenciaUsuario": gerenciausuario,
    };
  }
}
