part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeLoadingEvent extends HomeEvent{
  const HomeLoadingEvent();
  List<Object?> get props => [];
}
