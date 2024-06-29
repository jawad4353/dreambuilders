part of 'profile_bloc.dart';

abstract class ProfileStates extends Equatable{
  const ProfileStates();
}

class ProfileInitialState extends ProfileStates {
  @override
  List<Object> get props => [];
}


class ProfileLoadingState extends ProfileStates {
  @override
  List<Object> get props => [];
}


class ProfileLoadedState extends ProfileStates {
  final UserModel myModel;
  const ProfileLoadedState(this.myModel);
  @override
  List<Object> get props => [myModel];
}

class ProfileErrorState extends ProfileStates {
  @override
  List<Object> get props => [];
}

