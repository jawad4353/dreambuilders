part of 'live_tracking_bloc.dart';

abstract class LiveTrackingState extends Equatable{
  const LiveTrackingState();
}

class LiveTrackingInitial extends LiveTrackingState {
  @override
  List<Object> get props => [];
}

class LiveTrackingLoadingState extends LiveTrackingState {
  const LiveTrackingLoadingState();
  @override
  List<Object> get props => [];
}


class LiveTrackingLoadedState extends LiveTrackingState {
  final LatLng currentPosition;
  const LiveTrackingLoadedState(this.currentPosition);
  @override
  List<Object> get props => [currentPosition];
}


class LiveTrackingErrorState extends LiveTrackingState {
  @override
  List<Object> get props => [];
}

