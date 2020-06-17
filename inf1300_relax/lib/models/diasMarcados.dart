class diasMarcados {
  String id;
  String diaSemana;
  int humor;

  diasMarcados({this.id, this.diaSemana, this.humor});

  diasMarcados.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diaSemana = json['diaSemana'];
    humor = json['humor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diaSemana'] = this.diaSemana;
    data['humor'] = this.humor;
    return data;
  }

  @override
  String toString() {
    return 'WorldPopulation{id: $id, diaSemana: $diaSemana, humor: $humor}';
  }
}