part of 'steel_bloc.dart';

abstract class SteelEvent extends Equatable {
  const SteelEvent();
}

class SteelLoadingEvent extends SteelEvent{
  final double length,width,diameter,density;
  const SteelLoadingEvent(this.length,this.width,this.diameter,this.density);
  List<Object?> get props => [];
}
