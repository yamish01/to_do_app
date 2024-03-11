import "package:flutter/foundation.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import "package:sqflite_common_ffi_web/sqflite_ffi_web.dart";

class ToDoDb {
  ToDoDb._privateConstructor();
  static final ToDoDb instance = ToDoDb._privateConstructor();
  var _databaseName = "note.db";
  var TodoTableName = "todo";
  var id = "id";
  var task = "task";
  var date = "date";
  var isCompleted = "isCompleted ";
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initiateDatabase();
    return _database;
  }

  Future<Database> initiateDatabase() async {
    print("in database intialise method");
    var path = await getDatabasesPath();
    var database;

    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
      path = _databaseName;
    }
    try {
      database = openDatabase(join(path, _databaseName),
          version: 1, onConfigure: _onConfigure, onCreate: (((db, version) {
        db.execute(
            "CREATE TABLE IF NOT EXISTS $TodoTableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $task TEXT, $date STRING, $isCompleted INTEGER)");
        print("in open database ");
        return db;
      })));
    } catch (exception) {
      print("in exception ");
    }
    return database;
  }

  static Future _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }
}
