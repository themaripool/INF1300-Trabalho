import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String name;
  String userId;

  User(this.name, this.userId);

  User.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    name = snapshot.value["name"];

  toJson() {
    return {
      "userId": userId,
      "name": name,
    };
  }
}