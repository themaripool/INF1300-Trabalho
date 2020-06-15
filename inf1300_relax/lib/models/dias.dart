import 'package:firebase_database/firebase_database.dart';

class Dias {
  String key;
  String dia;
  String diario;
  int humor;

  Dias(this.dia, this.diario, this.humor);

  Dias.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    dia = snapshot.value["dia"],
    diario = snapshot.value["diario"],
    humor = snapshot.value["humor"];

  toJson() {
    return {
      "dia": dia,
      "diario": diario,
      "humor": humor,
    };
  }
}

