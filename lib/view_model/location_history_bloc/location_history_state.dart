part of 'location_history_bloc.dart';

abstract class LocationHistoryState extends Equatable{
  const LocationHistoryState();
}

class LocationHistoryInitial extends LocationHistoryState {
  @override
  List<Object> get props => [];
}

class LocationHistoryLoadingState extends LocationHistoryState {
  const LocationHistoryLoadingState();
  @override
  List<Object> get props => [];
}


class LocationHistoryLoadedState extends LocationHistoryState {
  final List<Location> listHistory;
  const LocationHistoryLoadedState(this.listHistory);
  @override
  List<Object> get props => [listHistory];
}


class LocationHistoryErrorState extends LocationHistoryState {
  final String error;
  const LocationHistoryErrorState(this.error);
  @override
  List<Object> get props => [];
}

