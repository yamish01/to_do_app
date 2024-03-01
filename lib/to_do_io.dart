import "package:sqflite/sqflite.dart";
import "package:to_do_app/to_do_db.dart";
import "package:to_do_app/to_do_model.dart";

import 'to_do_db.dart';

class TodoDbIO {
  ToDoDb? databaseProvider;
  TodoDbIO() {
    databaseProvider = ToDoDb.instance;
  }

  void insertIntoTaskTable(ToDoModel toDoModel) async {
    Database? db = await databaseProvider!.database;
    await db!.insert(ToDoDb.instance.TodoTableName, toDoModel.toJson());
  }

  Future<List<ToDoModel>> getFromTaskTable() async {
    Database? db = await databaseProvider!.database;
    List<Map<String, dynamic>> data =
        await db!.query(ToDoDb.instance.TodoTableName);
    print("data $data");
    return List.generate(data.length, (i) {
      return ToDoModel(
          id: data[i]["id"],
          task: data[i]['task'],
          isCompleted: data[i]['isCompleted'],
          date: data[i]["date"]);
    });
  }

  void updateTodo(ToDoModel toDoModel, int id) async {
    Database? db = await databaseProvider!.database;
    await db!.update(ToDoDb.instance.TodoTableName, toDoModel.toJson(),
        where: " id = ? ", whereArgs: [id]);
  }

  void deletedTodo(ToDoModel toDoModel, int id) async {
    Database? db = await databaseProvider!.database;
    await db!
        .delete(ToDoDb.instance.TodoTableName, where: "id=?", whereArgs: [id]);
  }
}
