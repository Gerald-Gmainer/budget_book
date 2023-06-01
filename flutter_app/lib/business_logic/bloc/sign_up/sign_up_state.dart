part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState(this.message);
}
