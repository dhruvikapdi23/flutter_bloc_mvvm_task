import 'dart:developer';
import 'dart:ui';

import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/extension/widget_extension.dart';
import 'package:dhruvi_todo_task/presentation/views/home/widgets/create_task_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/local/task.dart';
import '../../../data/repositories/binance_repository.dart';
import '../../../data/repositories/memo_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ToDoTaskRepository toDoTaskRepository;

  HomeCubit({required this.toDoTaskRepository}) : super(const HomeState());

  int selected = -1;
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController search = TextEditingController();

  onExpansionChange(newState, index) {
    if (newState) {
      const Duration(seconds: 20000);
      selected = index;
    } else {
      selected = -1;
    }
    emit(state.copyWith(errorMessage: null));
  }

  Future<void> readTasks() async {
    try {
      final memos = await toDoTaskRepository.readTasks();
      emit(state.copyWith(memos: memos, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> addTask(context) async {
    try {
      Task task =
          Task(title: titleCtrl.text, description: desc.text, isCompleted: 0);
      await toDoTaskRepository.addTask(task);
      readTasks();
      Navigator.pop(context);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteTask(Task memo) async {
    try {
      await toDoTaskRepository.deleteTask(memo);
      readTasks();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteAllTask() async {
    try {
      await toDoTaskRepository.deleteAllTask();
      readTasks();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateTask(Task memo) async {
    try {
      int isCompleted = memo.isCompleted == 0 ? 1 : 0;
      log("isCompleted ;$isCompleted");
      Task task = Task(
          title: memo.title,
          id: memo.id,
          description: memo.description,
          isCompleted: isCompleted);

      await toDoTaskRepository.updateTask(task);
      readTasks();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> searchTask() async {
    try {
      if (search.text.isNotEmpty) {
        final memos = await toDoTaskRepository.searchTask(search.text);
        emit(state.copyWith(memos: memos, errorMessage: null));

      } else {
        final memos = await toDoTaskRepository.readTasks();
        emit(state.copyWith(memos: memos, errorMessage: null));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  showSuccessBottomSheet(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 5,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.greyColor.withOpacity(.50),
                      offset: Offset(0, -6),
                      blurRadius: 24)
                ]),
            child: CreateTaskSheet(
                titleCtrl: titleCtrl,
                descCtrl: desc,
                onTap: () => addTask(context)).paddingDirectional(
              vertical: 32,
            ),
          );
        },
      );
}
