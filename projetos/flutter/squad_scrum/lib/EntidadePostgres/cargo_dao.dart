class CargoDAO{
  int? idCargo;
  String descricao;

  CargoDAO({this.idCargo, required this.descricao});

  factory CargoDAO.fromJson(Map<String, dynamic> json) {
    return CargoDAO(
      idCargo: json["id_cargo"],
      descricao: json["descricao"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_cargo": idCargo ?? "",
      "descricao": descricao,
    };
  }
}