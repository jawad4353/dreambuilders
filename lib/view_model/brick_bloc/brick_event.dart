part of 'brick_bloc.dart';

abstract class BrickEvent extends Equatable {
  const BrickEvent();
}

class BrickLoadingEvent extends BrickEvent{
  final double length,width,thickness,wastePercentage;
  const BrickLoadingEvent(this.length,this.width,this.thickness,this.wastePercentage);
  List<Object?> get props => [];
}
