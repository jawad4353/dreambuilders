part of 'bottom_navbar_bloc.dart';

abstract class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();
}

class BottomNavBarChangePageEvent extends BottomNavBarEvent{
  final int pageIndex;
  const BottomNavBarChangePageEvent(this.pageIndex);
  @override
  List<Object?> get props => [pageIndex];
}

