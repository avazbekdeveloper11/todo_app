import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/infrastructure/models/todo_model.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;
  factory LocalDatabase() {
    return getInstance;
  }

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("todo.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: (db, ver) async {
      const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
      const textType = "TEXT NOT NULL";

      await db.execute('''
      CREATE TABLE $todoTable (
      ${TodoFields.id} $idType,
      ${TodoFields.name} $textType,
      ${TodoFields.description} $textType,
      ${TodoFields.location} $textType,
      ${TodoFields.time} $textType,
      ${TodoFields.date} $textType,
      ${TodoFields.color} $textType
      )
      ''');
    });
  }

  static Future close() async {
    final db = await getInstance.database;
    db.close();
  }

  static Future<int> deleteTodoById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(todoTable, where: "${TodoFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<List<TodoModel>> getAllTodo() async {
    final db = await getInstance.database;
    const orderBy = "${TodoFields.name} ASC";
    final result = await db.query(
      todoTable,
      orderBy: orderBy,
    );
    return result.map((json) => TodoModel.fromJson(json)).toList();
  }

  static Future<List<TodoModel>> getByDate(String date) async {
    final db = await getInstance.database;
    final results = await db.query(
      todoTable,
      columns: TodoFields.values,
      where: '${TodoFields.date} = ?',
      whereArgs: [date],
    );
    if (results.isNotEmpty) {
      return results.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<TodoModel> inserttodo(TodoModel todoModel) async {
    final db = await getInstance.database;
    final id = await db.insert(todoTable, todoModel.toJson());
    return todoModel.copyWith(id: id);
  }

  static Future<int> updateTodo(TodoModel todoModel, int id) async {
    final db = await getInstance.database;
    return await db.update(
      todoTable,
      todoModel.toJson(),
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );
  }
}
