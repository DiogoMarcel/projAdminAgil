class SprintPesquisaDAO {
  int? idSprintPesquisa;
  int? idPesquisa;
  int idSprint;

  SprintPesquisaDAO({this.idSprintPesquisa, this.idPesquisa, required this.idSprint});

  factory SprintPesquisaDAO.fromJson(Map<String, dynamic> json) {
    return SprintPesquisaDAO(
      idSprintPesquisa: json['id_sprintpesquisa'],
      idPesquisa: json['idpesquisa'],
      idSprint: json['idsprint'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_sprintpesquisa': idSprintPesquisa ?? "",
      'idpesquisa': idPesquisa,
      'idsprint': idSprint,
    };
  }
}