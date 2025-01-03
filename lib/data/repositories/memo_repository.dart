import '../data_source/localdb/daos/memo_dao.dart';
import '../models/local/task.dart';

class ToDoTaskRepository{

  ToDoTaskRepository({
    required this.toDoTask
  });

  final ToDoTask toDoTask;

  Future<List<Task>> readTasks() => toDoTask.getAllTasks();

  Future<List<Task>> searchTask(text) => toDoTask.searchTask(text);

  Future<void> addTask(Task memo) => toDoTask.insertTask(memo);

  Future<void> deleteTask(Task memo) => toDoTask.deleteTask(memo);

  Future<void> deleteAllTask() => toDoTask.deleteAllTask();

  Future<void> updateTask(Task memo) => toDoTask.updateTask(memo);

}