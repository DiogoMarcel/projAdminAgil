import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';

class SprintDAO {
  int? idSprint;
  DateTime dataInicio;
  DateTime dataFinal;
  String nome;
  PesquisaDAO? pesquisaDAO;

  SprintDAO(
      {this.idSprint,
      required this.dataInicio,
      required this.dataFinal,
      required this.nome,
      this.pesquisaDAO});

  factory SprintDAO.fromJson(Map<String, dynamic> json) {
    return SprintDAO(
      idSprint: int.parse(json['id_sprint']),
      dataInicio: DateTime.parse(json['datainicio']),
      dataFinal: DateTime.parse(json['datafinal']),
      nome: json['nome'],
      pesquisaDAO: PesquisaDAO(
        idPesquisa: _getIdPesquisaFromJson(json),
        titulo: json['pesquisa']['titulo'] ?? "",
      ),
    );
  }

  static int? _getIdPesquisaFromJson(value) {
    if (value['pesquisa']['id_pesquisa'] != null) {
      return int.parse(value['pesquisa']['id_pesquisa']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id_sprint': idSprint.toString(),
      'datainicio': dataInicio.toUtc().toIso8601String(),
      'datafinal': dataFinal.toUtc().toIso8601String(),
      'nome': nome,
      'pesquisa': {
        'id_pesquisa': pesquisaDAO!.idPesquisa.toString(),
        'titulo': pesquisaDAO!.titulo,
      },
    };
  }
}
