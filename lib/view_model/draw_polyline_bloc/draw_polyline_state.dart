part of 'draw_polyline_bloc.dart';

abstract class DrawPolyLineState extends Equatable{
  const DrawPolyLineState();
}

class DrawPolyLineInitial extends DrawPolyLineState {
  @override
  List<Object> get props => [];
}

class DrawPolyLineLoadingState extends DrawPolyLineState {
  const DrawPolyLineLoadingState();
  @override
  List<Object> get props => [];
}


class DrawPolyLineLoadedState extends DrawPolyLineState {
  final LatLng currentPosition;
  final Set<Marker> markers ;
  final List<Polyline> polylines;
  const DrawPolyLineLoadedState(this.currentPosition,this.markers,this.polylines);
  @override
  List<Object> get props => [currentPosition,markers,polylines];
}


class DrawPolyLineErrorState extends DrawPolyLineState {
  final String message;
 const DrawPolyLineErrorState(this.message);
  @override
  List<Object> get props => [message];
}

