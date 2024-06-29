part of 'bottom_navbar_bloc.dart';

abstract class BottomNavBarStates extends Equatable{
  const BottomNavBarStates();
}

class BottomNavBarInitialState extends BottomNavBarStates {
  @override
  List<Object> get props => [];
}


class BottomNavBarLoadingState extends BottomNavBarStates {
  @override
  List<Object> get props => [];
}


class BottomNavBarLoadedState extends BottomNavBarStates {
  final int pageIndex;
  const BottomNavBarLoadedState(this.pageIndex);
  @override
  List<Object> get props => [pageIndex];
}

