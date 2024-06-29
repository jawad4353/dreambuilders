part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileLoadEvent extends ProfileEvent{
  const ProfileLoadEvent();
  @override
  List<Object?> get props => [];
}

class ProfileClearEvent extends ProfileEvent{
  const ProfileClearEvent();
  @override
  List<Object?> get props => [];
}
