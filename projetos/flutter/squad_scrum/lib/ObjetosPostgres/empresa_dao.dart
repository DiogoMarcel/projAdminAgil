class EmpresaDAO {
  int? idEmpresa;
  String nome;

  EmpresaDAO({this.idEmpresa, required this.nome});

  factory EmpresaDAO.fromJson(Map<String, dynamic> json) {
    return EmpresaDAO(
      idEmpresa: json["Id_Empresa"],
      nome: json["Nome"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id_Empresa": idEmpresa ?? "",
      "Nome": nome,
    };
  }
}