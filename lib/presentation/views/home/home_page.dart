import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_fonts.dart';
import 'package:dhruvi_todo_task/constants/app_img.dart';
import 'package:dhruvi_todo_task/constants/extension/spacing.dart';
import 'package:dhruvi_todo_task/constants/extension/widget_extension.dart';
import 'package:dhruvi_todo_task/presentation/views/widgets/button_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../di/dependency_injection.dart';
import '../../blocs/home/home_cubit.dart';
import '../../blocs/home/home_state.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator.get<HomeCubit>()..readTasks(),

      child: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeCubit>();
    home.search.text = "";
    home.readTasks();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (c, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: AppFonts.welcome,
                    style: Theme.of(context).textTheme.displayLarge,
                    children: [
                      TextSpan(
                          text: " ${AppFonts.john}",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: Theme.of(context).primaryColor)),
                      TextSpan(
                          text: ".",
                          style: Theme.of(context).textTheme.displayLarge)
                    ]),
              ),
              const VSpace(12),
              Text(AppFonts.youHaveGot(state.memos.length),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppColors.slateBlueColor)),
              const VSpace(32),
              state.memos.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(AppImages.noTask),
                        const VSpace(24),
                        Text(AppFonts.youHaveNoTask),
                        const VSpace(28),
                        ButtonCommon(
                          width: 151,
                          title: AppFonts.createTask,
                          onTap: () => home.showSuccessBottomSheet(context),
                          color:
                              Theme.of(context).primaryColor.withOpacity(.10),
                          icon: SvgPicture.asset(AppSvg.plus1),
                        )
                      ],
                    )
                      .alignment(Alignment.bottomCenter)
                      .height(MediaQuery.sizeOf(context).height / 2)
                  : ListView.builder(
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
                              trailing: index == home.selected
                                  ? const Column()
                                  : SvgPicture.asset(AppSvg.tablerDots),
                              dense: true,
                              leading: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border:
                                        Border.all(color: AppColors.greyColor)),
                                child: state.memos[index].isCompleted == 1
                                    ? SvgPicture.asset(AppSvg.checked)
                                    : null,
                              ).inkWell(
                                  onTap: () =>
                                      home.updateTask(state.memos[index])),
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
                                    .paddingDirectional(
                                        horizontal: 40, vertical: 8)
                              ]),
                        ),
                      ),
                      itemCount: state.memos.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
            ],
          ).paddingDirectional(horizontal: 26, vertical: 38)),
        );
      },
    );
  }
}
