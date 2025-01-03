import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_fonts.dart';
import 'package:dhruvi_todo_task/constants/app_img.dart';
import 'package:dhruvi_todo_task/constants/extension/spacing.dart';
import 'package:dhruvi_todo_task/constants/extension/widget_extension.dart';
import 'package:dhruvi_todo_task/presentation/views/widgets/button_common.dart';
import 'package:dhruvi_todo_task/presentation/views/widgets/text_field_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../di/dependency_injection.dart';
import '../../blocs/home/home_cubit.dart';
import '../../blocs/home/home_state.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator.get<HomeCubit>()..readTasks(),
      child: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (c, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldCommon(
                controller: home.search,
                hintText: AppFonts.search,
                onChanged: (value) => home.searchTask(),
                prefixIcon: SvgPicture.asset(
                  AppSvg.search,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(home.search.text.isEmpty?AppColors.greyColor:AppColors.primaryColor, BlendMode.srcIn),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).primaryColor.withOpacity(.50))),
                suffixIcon: SvgPicture.asset(AppSvg.cancel)
                    .paddingDirectional(horizontal: 15),
              ),
              const VSpace(12),

              state.memos.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(AppImages.noTask),
                        const VSpace(24),
                        Text(AppFonts.noResult,style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.slateBlueColor)),
                        const VSpace(28),
                      ],
                    )
                      .alignment(Alignment.bottomCenter)
                      .height(MediaQuery.sizeOf(context).height / 2)
                  : home.search.text.isNotEmpty? ListView.builder(
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
                    ):Container()
            ],
          ).paddingDirectional(horizontal: 26, vertical: 38)),
        );
      },
    );
  }
}
