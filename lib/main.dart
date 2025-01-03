import 'package:dhruvi_todo_task/constants/app_theme.dart';
import 'package:dhruvi_todo_task/presentation/blocs/dashboard_cubit.dart';
import 'package:dhruvi_todo_task/presentation/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhruvi_todo_task/presentation/blocs/theme/theme_cubit.dart';
import 'package:dhruvi_todo_task/presentation/blocs/theme/theme_state.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'presentation/blocs/home/home_cubit.dart';
import 'presentation/views/views.dart';
import 'data/repositories/repositories.dart';
import 'di/dependency_injection.dart';

final GetIt locator = GetIt.instance;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(
              toDoTaskRepository: locator<ToDoTaskRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(prefs: locator<SharedPreferences>()),
          ),
          BlocProvider(
            create: (context) => DashboardCubit(pageController: PageController()),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'To-Do Task',
              localizationsDelegates: const [
                S.delegate,

              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: AppTheme.light,
              home: const Dashboard(),
            );
          },
        )
    );
  }
}

