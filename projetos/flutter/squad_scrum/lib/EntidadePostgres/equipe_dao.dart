class EquipeDAO {
  int? idEquipe;
  String nome;

  EquipeDAO({this.idEquipe, required this.nome});

  factory EquipeDAO.fromJson(Map<String, dynamic> json) {
    return EquipeDAO(
      idEquipe: json["id_equipe"],
      nome: json["nome"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_equipe": idEquipe ?? "",
      "nome": nome,
    };
  }
}
