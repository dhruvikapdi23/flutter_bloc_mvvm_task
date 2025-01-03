import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_fonts.dart';
import 'package:dhruvi_todo_task/constants/app_img.dart';
import 'package:dhruvi_todo_task/constants/extension/spacing.dart';
import 'package:dhruvi_todo_task/constants/extension/widget_extension.dart';
import 'package:dhruvi_todo_task/presentation/blocs/dashboard_cubit.dart';
import 'package:dhruvi_todo_task/presentation/views/widgets/button_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../di/dependency_injection.dart';
import '../../blocs/home/home_cubit.dart';
import '../../blocs/home/home_state.dart';


class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<HomeCubit, HomeState>(
      builder: (_, state) {
        return Scaffold(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: AppFonts.welcome,
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayLarge,
                        children: [
                          TextSpan(
                              text: " ${AppFonts.john}",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: Theme
                                  .of(context)
                                  .primaryColor)),
                          TextSpan(
                              text: ".",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayLarge)
                        ]),
                  ),
                  const VSpace(12),
                  Text(AppFonts.youHaveGot(7),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: AppColors.slateBlueColor)),
                  const VSpace(32),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(AppImages.noTask),
                      const VSpace(24),
                      Text(AppFonts.youHaveNoTask),
                      const VSpace(28),
                      ButtonCommon(
                        width: 151,
                        title: AppFonts.createTask,
                        onTap: () {
                          final home = context.read<HomeCubit>();
                          home.showSuccessBottomSheet(context);
                          final dash = context.read<DashboardCubit>();
                          dash.onChangeIntro(0);
                        },
                        color:
                        Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(.10),
                        icon: SvgPicture.asset(AppSvg.plus1),
                      )
                    ],
                  )
                      .alignment(Alignment.bottomCenter)
                      .height(MediaQuery
                      .sizeOf(context)
                      .height / 2)
                ],
              ).paddingDirectional(horizontal: 26, vertical: 38)),
        );
      },
    );
  }
}
