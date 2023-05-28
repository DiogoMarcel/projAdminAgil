class FuncaoDAO {
  int? idFuncao;
  String descricao;

  FuncaoDAO({this.idFuncao, required this.descricao});

  factory FuncaoDAO.fromJson(Map<String, dynamic> json) {
    return FuncaoDAO(
      idFuncao: json["Id_Funcao"],
      descricao: json["Descricao"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id_Funcao": idFuncao ?? "",
      "Descricao": descricao,
    };
  }
}
