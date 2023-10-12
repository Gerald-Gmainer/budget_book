part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final ProfileModel profile;
  final ProfileSettingModel profileSettingModel;

  LoginSuccessState(this.profile, this.profileSettingModel);
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}
