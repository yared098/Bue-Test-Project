// import 'dart:io' show Platform;
// import 'package:buedelivery/Todo/Model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'task_model.dart';

// class TaskRepository {
//   static Database? _db;

//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     return _db = await _initDB();
//   }

//   Future<Database> _initDB() async {
//     if (!(Platform.isAndroid || Platform.isIOS)) {
//       throw UnsupportedError('SQLite is only supported on Android/iOS.');
//     }

//     final dir = await getApplicationDocumentsDirectory();
//     final path = join(dir.path, 'tasks.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE tasks (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             title TEXT,
//             isCompleted INTEGER
//           )
//         ''');
//       },
//     );
//   }

//   Future<List<Task>> getTasks() async {
//     final db = await database;
//     final result = await db.query('tasks');
//     return result.map((e) => Task.fromMap(e)).toList();
//   }

//   Future<void> addTask(Task task) async {
//     final db = await database;
//     await db.insert('tasks', task.toMap());
//   }

//   Future<void> deleteTask(int id) async {
//     final db = await database;
//     await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<void> updateTask(Task task) async {
//     final db = await database;
//     await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
//   }
// }


import 'dart:convert';
import 'package:buedelivery/Todo/Model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TaskRepository {
  static const String _tasksKey = 'tasks';

  /// Load tasks from SharedPreferences
  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = prefs.getStringList(_tasksKey) ?? [];

    return taskStrings.map((str) {
      final map = jsonDecode(str);
      return Task.fromMap(map);
    }).toList();
  }

  /// Add a new task and save to SharedPreferences
  Future<void> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await getTasks();
    tasks.add(task);
    final taskStrings = tasks.map((t) => jsonEncode(t.toMap())).toList();
    await prefs.setStringList(_tasksKey, taskStrings);
  }

  /// Delete a task by ID and update SharedPreferences
  Future<void> deleteTask(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await getTasks();
    tasks.removeWhere((task) => task.id == id);
    final taskStrings = tasks.map((t) => jsonEncode(t.toMap())).toList();
    await prefs.setStringList(_tasksKey, taskStrings);
  }

  /// Update a task by ID and save changes to SharedPreferences
  Future<void> updateTask(Task updatedTask) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await getTasks();
    final updatedTasks = tasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    final taskStrings = updatedTasks.map((t) => jsonEncode(t.toMap())).toList();
    await prefs.setStringList(_tasksKey, taskStrings);
  }
}

