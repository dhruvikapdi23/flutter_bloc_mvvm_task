import 'package:dhruvi_todo_task/presentation/blocs/dashboard_cubit.dart';
import 'package:dhruvi_todo_task/presentation/blocs/home/home_cubit.dart';
import 'package:dhruvi_todo_task/presentation/blocs/sign_in/sign_in_cubit.dart';
import '../../data/data_source/localdb/daos/memo_dao.dart';
import '../../data/repositories/repositories.dart';
import '../dependency_injection.dart';
import 'base_module.dart';

final class RepositoryModule extends BaseModule {
  @override
  Future<void> register() async {
    locator.registerFactory(() => ToDoTaskRepository(toDoTask: locator.get<ToDoTask>()));
    locator.registerFactory(() => DashboardCubit());
    locator.registerFactory(() => SignInCubit());
    locator.registerFactory(() => HomeCubit(toDoTaskRepository: locator.get<ToDoTaskRepository>()));
  }
}