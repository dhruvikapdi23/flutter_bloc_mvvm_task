part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final PageController? pageController;
  final int? pageIndex;
  final List<Widget>? pages;
  final Function(int)? onChangeIntro;

  const DashboardState(
      {this.pageController, this.pageIndex, this.pages, this.onChangeIntro});

  DashboardState copyWith(
      {PageController? pageController,
      pageIndex,
      List<Widget>? pages,
      Function(int)? onChangeIntro}) {
    return DashboardState(
        pageController: pageController ?? PageController(),
        pageIndex: pageIndex ?? this.pageIndex,
        pages: pages ?? this.pages,
        onChangeIntro: onChangeIntro ?? this.onChangeIntro);
  }

  @override
  List<Object?> get props => [pageController, pageIndex,pages,onChangeIntro];
}
