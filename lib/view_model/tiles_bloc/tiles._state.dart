part of 'tiles_bloc.dart';

abstract class TilesState extends Equatable{
  const TilesState();
}

class TilesInitialState extends TilesState {
  @override
  List<Object> get props => [];
}


class TilesLoadingState extends TilesState {
  @override
  List<Object> get props => [];
}


class TilesLoadedState extends TilesState {
 final  Map<String,dynamic> result;
 const TilesLoadedState(this.result);
  @override
  List<Object> get props => [];
}


class TilesErrorState extends TilesState {
  final String error;
 const TilesErrorState(this.error);
  @override
  List<Object> get props => [];
}

