part of 'steel_bloc.dart';

abstract class SteelState extends Equatable{
  const SteelState();
}

class SteelInitialState extends SteelState {
  @override
  List<Object> get props => [];
}


class SteelLoadingState extends SteelState {
  @override
  List<Object> get props => [];
}


class SteelLoadedState extends SteelState {
 final  Map<String,dynamic> result;
 const SteelLoadedState(this.result);
  @override
  List<Object> get props => [];
}


class SteelErrorState extends SteelState {
  final String error;
 const SteelErrorState(this.error);
  @override
  List<Object> get props => [];
}

