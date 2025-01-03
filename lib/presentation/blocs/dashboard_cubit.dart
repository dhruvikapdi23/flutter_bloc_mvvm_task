import 'package:bloc/bloc.dart';
import 'package:dhruvi_todo_task/presentation/views/completed_screen/completed_screen.dart';
import 'package:dhruvi_todo_task/presentation/views/create_task/create_task.dart';
import 'package:dhruvi_todo_task/presentation/views/home/home_page.dart';
import 'package:dhruvi_todo_task/presentation/views/search_screen/search_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final PageController? pageController;
  final int? currentIndex;
  final List<Widget>? pages;

  DashboardCubit({
     this.pageController,
     this.currentIndex,
     this.pages,
  }) : super(const DashboardState());

  init(){
    emit(state.copyWith(pageIndex: 0,pages: pageList,pageController: PageController()));
  }

  onChangeIntro(text) {


    emit(state.copyWith(pageIndex: text));

  }



  final List<Widget> pageList = [
    const Home(),
    const CreateTaskPage(),
    const SearchScreen(),
    const CompletedScreen()
 /*   const HomeScreen(),
    const HighColorLightListsScreen(),
    const BookmarkScreen(),
    const SettingScreen()*/
  ];

}


