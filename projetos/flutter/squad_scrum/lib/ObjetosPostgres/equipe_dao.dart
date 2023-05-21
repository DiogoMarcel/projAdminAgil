class EquipeDAO {
  int? idEquipe;
  String nome;

  EquipeDAO({this.idEquipe, required this.nome});

  factory EquipeDAO.fromJson(Map<String, dynamic> json) {
    return EquipeDAO(
      idEquipe: json["Id_Equipe"],
      nome: json["Nome"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id_Equipe": idEquipe ?? "",
      "Nome": nome,
    };
  }
}
