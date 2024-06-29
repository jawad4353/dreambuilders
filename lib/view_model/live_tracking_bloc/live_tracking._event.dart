part of 'live_tracking_bloc.dart';

abstract class LiveTrackingEvent extends Equatable {
  const LiveTrackingEvent();
}


class LiveTrackingLoadEvent extends LiveTrackingEvent{
  final LatLng currentPosition;
  const LiveTrackingLoadEvent(this.currentPosition);
  @override
  List<Object?> get props => [currentPosition];
}


class FetchLocationEvent extends LiveTrackingEvent{
  final BuildContext context;
  const FetchLocationEvent(this.context);
  @override
  List<Object?> get props => [context];
}
