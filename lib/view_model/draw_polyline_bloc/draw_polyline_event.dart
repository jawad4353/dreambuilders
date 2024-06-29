part of 'draw_polyline_bloc.dart';

abstract class DrawPolyLineEvent extends Equatable {
  const DrawPolyLineEvent();
}


class DrawPolyLineLoadEvent extends DrawPolyLineEvent{
  final LatLng currentPosition;
  const DrawPolyLineLoadEvent(this.currentPosition);
  @override
  List<Object?> get props => [currentPosition];
}


class FetchLocationEvent extends DrawPolyLineEvent{
  final dynamic destinationLocation;
  const FetchLocationEvent(this.destinationLocation);
  @override
  List<Object?> get props => [destinationLocation];
}
