part of 'tiles_bloc.dart';

abstract class TilesEvent extends Equatable {
  const TilesEvent();
}

class TilesLoadingEvent extends TilesEvent{
  final double lengthFloor,widthFloor,lengthTile,widthTile,wastePercentage;
  const TilesLoadingEvent(this.lengthFloor,this.widthFloor,this.lengthTile,this.widthTile,this.wastePercentage);
  List<Object?> get props => [];
}
