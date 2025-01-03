import 'dart:developer';

import '../database/app_db.dart';
import '../../../models/local/task.dart';

class ToDoTask {
  ToDoTask({required this.appDB});

  final AppDB appDB;

  Future<List<Task>> getAllTasks() async {
    final db = await appDB.database;
    final result = await db.query(AppDB.taskTable);

    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<List<Task>> searchTask(text) async {
    final db = await appDB.database;
    final res = await db.rawQuery(
        "SELECT * FROM ${AppDB.taskTable} WHERE title LIKE '%${text}%'");

  /*  final result = await db.query(AppDB.taskTable,
        where: '${AppDB.taskTitle} = ?', whereArgs: [text]);*/

    return res.map((json) => Task.fromMap(json)).toList();
  }

  Future<void> insertTask(Task memo) async {
    log("memo ;$memo");
    final db = await appDB.database;
    await db.insert(AppDB.taskTable, memo.toMap());
  }

  Future<void> updateTask(Task memo) async {
    final db = await appDB.database;
    await db.update(
      AppDB.taskTable,
      memo.toMap(),
      where: '${AppDB.taskColumnId} = ?',
      whereArgs: [memo.id],
    );
  }

  Future<void> deleteTask(Task memo) async {
    final db = await appDB.database;
    await db.delete(
      AppDB.taskTable,
      where: '${AppDB.taskColumnId} = ?',
      whereArgs: [memo.id],
    );
  }

  Future<void> deleteAllTask() async {
    final db = await appDB.database;
    await db.delete(
      AppDB.taskTable,
    );
  }
}
