import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/connectivity_singleton.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepo;

  LoginBloc(this.userRepo) : super(LoginInitState()) {
    on<GoogleLoginEvent>(_onGoogleLoginEvent);
    on<CredentialsLoginEvent>(_onCredentialsLoginEvent);
  }

  _onGoogleLoginEvent(GoogleLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      BudgetLogger.instance.d("login with google");
      final response = await userRepo.googleLogin();
      if (response) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState("TODO error message"));
      }
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(LoginErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(LoginErrorState("TODO error message"));
      }
    }
  }

  _onCredentialsLoginEvent(CredentialsLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      BudgetLogger.instance.d("login with credentials");
      final response = await userRepo.credentialsLogin(event.email, event.password);
      if (response) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState("TODO error message"));
      }
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(LoginErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(LoginErrorState("TODO error message"));
      }
    }
  }
}
