import 'package:squad_scrum/EntidadePostgres/sprint_pesquisa_dao.dart';

class SprintDAO {
  int? idSprint;
  DateTime dataInicio;
  DateTime dataFinal;
  String nome;
  SprintPesquisaDAO? pesquisaDAO;

  SprintDAO(
      {this.idSprint,
      required this.dataInicio,
      required this.dataFinal,
      required this.nome,
      this.pesquisaDAO});

  factory SprintDAO.fromJson(Map<String, dynamic> json) {
    return SprintDAO(
      idSprint: json['id_sprint'],
      dataInicio: DateTime.parse(json['datainicio']),
      dataFinal: DateTime.parse(json['datafinal']),
      nome: json['nome'],
      pesquisaDAO: SprintPesquisaDAO(
        idSprint: json['sprintpesquisa']['idsprint'],
        idPesquisa: json['sprintpesquisa']['idpesquisa'],
        idSprintPesquisa: json['sprintpesquisa']['id_pesquisasprint'],
      ),
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
