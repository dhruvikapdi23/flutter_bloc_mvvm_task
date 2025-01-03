import 'dart:developer';

import 'package:dhruvi_todo_task/constants/app_fonts.dart';
import 'package:dhruvi_todo_task/constants/extension/widget_extension.dart';
import 'package:dhruvi_todo_task/data/models/local/task.dart';
import 'package:dhruvi_todo_task/presentation/blocs/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_img.dart';
import '../../../main.dart';
import '../../blocs/home/home_state.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator.get<HomeCubit>()..readTasks(),
      child: const CompletedScreen(),
    );
  }
}

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeCubit>();
    home.readTasks();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<Task> completedTask = state.memos.where((element) {
          log("AAA :${element.isCompleted}");
          return element.isCompleted == 1;
        }).toList();
        log("completedTask:${state.memos.length}");
        return Scaffold(
          body: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppFonts.completedTasks,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    AppFonts.deleteAll,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColors.redColor),
                  ).inkWell(onTap: () => home.deleteAllTask())
                ],
              ),
              ListView.builder(
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                        expansionAnimationStyle:
                            AnimationStyle(curve: Curves.fastOutSlowIn),
                        key: Key(home.selected.toString()),
                        initiallyExpanded: index == home.selected,
                        onExpansionChanged: (newState) =>
                            home.onExpansionChange(newState, index),
                        //atten
                        tilePadding: EdgeInsets.zero,
                        trailing: SvgPicture.asset(AppSvg.delete).inkWell(
                            onTap: () => home.deleteTask(completedTask[index])),
                        dense: true,
                        leading: Container(
                          height: 24,
                          width: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: AppColors.greyColor.withOpacity(.50)),
                          child: SvgPicture.asset(AppSvg.tick),
                        ).inkWell(
                            onTap: () => home.updateTask(state.memos[index])),
                        title: Text(state.memos[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 16)),
                        children: <Widget>[
                          Text(
                            state.memos[index].description,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontFamily:
                                        GoogleFonts.urbanist().fontFamily,
                                    fontSize: 14,
                                    color: AppColors.greyColor),
                            textAlign: TextAlign.start,
                          )
                              .alignment(Alignment.centerLeft)
                              .paddingDirectional(horizontal: 40, vertical: 8)
                        ]),
                  ),
                ),
                itemCount: completedTask.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ).paddingDirectional(horizontal: 42, vertical: 38)),
        );
      },
    );
  }
}
