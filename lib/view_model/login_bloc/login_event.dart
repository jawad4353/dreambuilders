part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginApiEvent extends LoginEvent{
  final BuildContext context;
  final String email;
  final String password;
  const LoginApiEvent( this.email, this.password, this.context);
  @override
  List<Object?> get props => [context,email,password];
}


class ForgetPasswordEvent extends LoginEvent{
  final String email;
  final BuildContext context;
  const ForgetPasswordEvent(this.email,this.context);
  @override
  List<Object?> get props => [email,context];
}

