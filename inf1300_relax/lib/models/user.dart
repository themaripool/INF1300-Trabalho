import 'package:firebase_database/firebase_database.dart';

class Todo {
  String key;
  String name;
  bool completed;
  String userId;

  Todo(this.name, this.userId, this.completed);

  Todo.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    name = snapshot.value["name"],
    completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "name": name,
      "completed": completed,
    };
  }
}