import 'dart:io' show Platform;
import 'package:buedelivery/Todo/Model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class TaskRepository {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    return _db = await _initDB();
  }

  Future<Database> _initDB() async {
    if (!(Platform.isAndroid || Platform.isIOS)) {
      throw UnsupportedError('SQLite is only supported on Android/iOS.');
    }

    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks');
    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<void> addTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }
}



