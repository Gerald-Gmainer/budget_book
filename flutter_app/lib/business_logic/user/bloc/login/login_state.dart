part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final ProfileModel profile;

  LoginSuccessState(this.profile);
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}
