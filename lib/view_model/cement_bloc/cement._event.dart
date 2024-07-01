part of 'cement_bloc.dart';

abstract class CementEvent extends Equatable {
  const CementEvent();
}

class CementLoadingEvent extends CementEvent{
  final double length,width,thickness;
  const CementLoadingEvent(this.length,this.width,this.thickness);

  List<Object?> get props => [];
}

class CementLoadedEvent extends CementEvent{
  const CementLoadedEvent();
  @override
  List<Object?> get props => [];
}
