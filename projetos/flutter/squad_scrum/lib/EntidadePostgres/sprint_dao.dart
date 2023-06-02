class SprintDAO {
  int? idSprint;
  DateTime dataInicio;
  DateTime dataFinal;
  String nome;

  SprintDAO({this.idSprint, required this.dataInicio, required this.dataFinal, required this.nome});

  factory SprintDAO.fromJson(Map<String, dynamic> json) {
    return SprintDAO(
      idSprint: json['id_sprint'],
      dataInicio: DateTime.parse(json['datainicio']),
      dataFinal: DateTime.parse(json['datafinal']),
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_sprint': idSprint ?? "",
      'datainicio': dataInicio.toUtc().toIso8601String(),
      'datafinal': dataFinal.toUtc().toIso8601String(),
      'nome': nome,
    };
  }
}
