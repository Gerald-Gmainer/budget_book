part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class InitSignUpEvent extends SignUpEvent {}

class SignUpNowEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpNowEvent(this.email, this.password);
}
