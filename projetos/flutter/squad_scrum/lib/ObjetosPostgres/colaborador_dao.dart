class ColaboradorDAO {
  int? idColaborador;
  String usuario;
  String senha;
  String nome;
  bool gerenciapesquisa;
  bool gerenciausuario;

  ColaboradorDAO(
      {this.idColaborador,
      required this.usuario,
      required this.senha,
      required this.nome,
      required this.gerenciapesquisa,
      required this.gerenciausuario});

  factory ColaboradorDAO.fromJson(Map<String, dynamic> json) {
    return ColaboradorDAO(
      idColaborador: json["Id_Colaborador"],
      usuario: json["Usuario"],
      senha: json["Senha"],
      nome: json["Nome"],
      gerenciapesquisa: json["GerenciaPesquisa"],
      gerenciausuario: json["GerenciaUsuario"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id_Colaborador": idColaborador ?? "",
      "Usuario": usuario,
      "Senha": senha,
      "Nome": nome,
      "GerenciaPesquisa": gerenciapesquisa,
      "GerenciaUsuario": gerenciausuario,
    };
  }
}
