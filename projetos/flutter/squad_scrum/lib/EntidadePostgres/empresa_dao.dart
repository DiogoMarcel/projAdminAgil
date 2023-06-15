class EmpresaDAO {
  int? idEmpresa;
  String nome;

  EmpresaDAO({this.idEmpresa, required this.nome});

  factory EmpresaDAO.fromJson(Map<String, dynamic> json) {
    return EmpresaDAO(
      idEmpresa: int.parse(json["id_empresa"]),
      nome: json["nome"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_empresa": idEmpresa.toString(),
      "nome": nome,
    };
  }
}