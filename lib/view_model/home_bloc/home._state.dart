part of 'home_bloc.dart';

abstract class HomeState extends Equatable{
  const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}


class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}


class HomeLoadedState extends HomeState {
 final  Map<String,dynamic> result;
 const HomeLoadedState(this.result);
  @override
  List<Object> get props => [];
}


class HomeErrorState extends HomeState {
  final String error;
 const HomeErrorState(this.error);
  @override
  List<Object> get props => [];
}

