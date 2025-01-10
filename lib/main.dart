import 'package:dhruvi_todo_task/constants/app_theme.dart';
import 'package:dhruvi_todo_task/presentation/blocs/dashboard_cubit.dart';
import 'package:dhruvi_todo_task/presentation/blocs/sign_in/sign_in_cubit.dart';
import 'package:dhruvi_todo_task/presentation/views/dashboard/dashboard_screen.dart';
import 'package:dhruvi_todo_task/presentation/views/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhruvi_todo_task/presentation/blocs/theme/theme_cubit.dart';
import 'package:dhruvi_todo_task/presentation/blocs/theme/theme_state.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'generated/l10n.dart';
import 'presentation/blocs/home/home_cubit.dart';
import 'presentation/views/views.dart';
import 'data/repositories/repositories.dart';
import 'di/dependency_injection.dart';

final GetIt locator = GetIt.instance;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.register();
  await  Supabase.initialize(
    url: 'https://uvqqiupazcqjzeqrezpn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2cXFpdXBhemNxanplcXJlenBuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0OTMyNDUsImV4cCI6MjA1MjA2OTI0NX0.Zb_Ra3h929yPVK5zE203nXN6ZvIxMzu7Bc2766dltow',
  );
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
          BlocProvider(
            create: (context) => SignInCubit(),
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
              home: const SignIn(),
            );
          },
        )
    );
  }
}

