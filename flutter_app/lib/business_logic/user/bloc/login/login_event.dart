part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class InitLoginEvent extends LoginEvent {}

class GoogleLoginEvent extends LoginEvent {}

class CredentialsLoginEvent extends LoginEvent {
  final String email;
  final String password;

  CredentialsLoginEvent(this.email, this.password);
}

class LogoutEvent extends LoginEvent {}
