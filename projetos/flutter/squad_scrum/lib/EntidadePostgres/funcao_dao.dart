class FuncaoDAO {
  int? idFuncao;
  String descricao;

  FuncaoDAO({this.idFuncao, required this.descricao});

  factory FuncaoDAO.fromJson(Map<String, dynamic> json) {
    return FuncaoDAO(
      idFuncao: json["id_funcao"],
      descricao: json["descricao"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_funcao": idFuncao ?? "",
      "descricao": descricao,
    };
  }
}
