import '../../data_source/localdb/localdb.dart';

class Task{
  final int? id;
  final String title;
  final String description;
  final int? isCompleted;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,

  });

  Map<String, Object?> toMap() => {
    AppDB.taskColumnId: id,
    AppDB.taskTitle: title,
    AppDB.taskDescription: description,
    AppDB.isCompleted: isCompleted,
  };

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map[AppDB.taskColumnId] as int?,
      title: map[AppDB.taskTitle] as String,
      description: map[AppDB.taskDescription] as String,
      isCompleted: map[AppDB.isCompleted] ?? 0,
    );
  }
}