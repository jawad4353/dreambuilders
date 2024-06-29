part of 'location_history_bloc.dart';

abstract class LocationHistoryEvent extends Equatable {
  const LocationHistoryEvent();
}


class LocationHistoryLoadEvent extends LocationHistoryEvent{
  const LocationHistoryLoadEvent();
  @override
  List<Object?> get props => [];
}

class LocationHistoryClearEvent extends LocationHistoryEvent{
  const LocationHistoryClearEvent();
  @override
  List<Object?> get props => [];
}

