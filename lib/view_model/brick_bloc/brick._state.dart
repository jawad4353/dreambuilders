part of 'brick_bloc.dart';

abstract class BrickState extends Equatable{
  const BrickState();
}

class BrickInitialState extends BrickState {
  @override
  List<Object> get props => [];
}


class BrickLoadingState extends BrickState {
  @override
  List<Object> get props => [];
}


class BrickLoadedState extends BrickState {
 final  Map<String,dynamic> result;
 const BrickLoadedState(this.result);
  @override
  List<Object> get props => [];
}


class BrickErrorState extends BrickState {
  final String error;
 const BrickErrorState(this.error);
  @override
  List<Object> get props => [];
}

