part of 'cement_bloc.dart';

abstract class CementState extends Equatable{
  const CementState();
}

class CementInitialState extends CementState {
  @override
  List<Object> get props => [];
}


class CementLoadingState extends CementState {
  @override
  List<Object> get props => [];
}


class CementLoadedState extends CementState {
 final  Map<String,dynamic> result;
 const CementLoadedState(this.result);
  @override
  List<Object> get props => [];
}


class CementErrorState extends CementState {
  final String error;
 const CementErrorState(this.error);
  @override
  List<Object> get props => [];
}

