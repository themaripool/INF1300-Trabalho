import 'package:firebase_database/firebase_database.dart';
import 'dias.dart';

class User {
  String key;
  List<Dias> dias;

  User();

  User.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    dias = snapshot.value["dias"];

  toJson() {
    return {
      "dias": dias,
    };
  }
}