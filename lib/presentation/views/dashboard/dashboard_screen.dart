import 'package:bloc/bloc.dart';
import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/extension/spacing.dart';
import 'package:dhruvi_todo_task/constants/extension/widget_extension.dart';
import 'package:dhruvi_todo_task/presentation/blocs/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../../constants/app_array.dart';
import '../../../constants/app_dimen.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_img.dart';
import '../../../main.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator.get<DashboardCubit>()..init(),
      child: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dash = context.read<DashboardCubit>();

    return BlocBuilder<DashboardCubit, DashboardState>(builder: (_, state) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {},
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            body: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor),
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: SvgPicture.asset(AppSvg.tick)),
                    const HSpace(8.8),
                    Text(AppFonts.taski,
                        style: Theme.of(context).textTheme.displayMedium)
                  ]),
                  Row(children: [
                    Text(AppFonts.john,
                        style: Theme.of(context).textTheme.displayMedium),
                    const HSpace(14),
                    Container(
                        height: 42,
                        width: 42,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(AppImages.user))))
                  ])
                ]).paddingDirectional(horizontal: 42,top: 38),
                Expanded(child: state.pages![state.pageIndex!]),
              ],
            ),
            bottomNavigationBar: Container(
              alignment: Alignment.bottomCenter,
              height: 100,

              padding: const EdgeInsets.only(top: 24.5,left: 46.5,right: 46.5),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.cardColor)),
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: AppArray()
                    .dashboardBottomList
                    .asMap()
                    .entries
                    .map((e) => Column(children: [
                          SvgPicture.asset(e.value["icon"],
                              height: AppDimens.dimen28,
                              width: AppDimens.dimen28,
                              fit: BoxFit.scaleDown,
                              colorFilter: ColorFilter.mode(
                                  state.pageIndex == e.key
                                      ? AppColors.primaryColor
                                      : AppColors.greyColor,
                                  BlendMode.srcIn)),
                          const VSpace(10),
                          Text(e.value["title"].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      color: state.pageIndex == e.key
                                          ? AppColors.primaryColor
                                          : AppColors.greyColor))
                        ]).inkWell(onTap: () => dash.onChangeIntro(e.key)))
                    .toList(),
              ),
            )),
      );
    });
  }
}
