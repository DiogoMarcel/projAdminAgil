class CargoDAO{
  int? idCargo;
  String descricao;

  CargoDAO({this.idCargo, required this.descricao});

  factory CargoDAO.fromJson(Map<String, dynamic> json) {
    return CargoDAO(
      idCargo: json["Id_Cargo"],
      descricao: json["Descricao"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id_Cargo": idCargo ?? "",
      "Descricao": descricao,
    };
  }
}