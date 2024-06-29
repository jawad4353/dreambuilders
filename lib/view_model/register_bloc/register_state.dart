part of 'register_bloc.dart';

abstract class RegisterUserState extends Equatable{
  const RegisterUserState();
}

class RegisterInitial extends RegisterUserState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterUserState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessfulState extends RegisterUserState {
  @override
  List<Object> get props => [];
}


class RegisterErrorState extends RegisterUserState {
  @override
  List<Object> get props => [];
}
