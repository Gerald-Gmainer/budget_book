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
    on<InitLoginEvent>(_onInitLoginEvent);
    on<GoogleLoginEvent>(_onGoogleLoginEvent);
    on<CredentialsLoginEvent>(_onCredentialsLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  _onInitLoginEvent(InitLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginInitState());
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
      BudgetLogger.instance.d("login with credentials ${event.email}");
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

        String message = "TODO error message";
        if (e.toString().contains("Invalid login credentials")) {
          message = "Invalid login credentials";
        }
        emit(LoginErrorState(message));
      }
    }
  }

  _onLogoutEvent(LogoutEvent event, Emitter<LoginState> emit) async {
    try {
      await userRepo.logout();
      emit(LoginInitState());
    } catch (e) {
      BudgetLogger.instance.e(e);
      if (e.toString().contains("User not found")) {
        // ignore that error
        emit(LoginInitState());
      } else {
        String message = "TODO error message";
        emit(LoginErrorState(message));
      }
    }
  }
}
