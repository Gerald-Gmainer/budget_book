import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/connectivity_singleton.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepo;
  final ProfileConverter _profileConverter = ProfileConverter();

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
      await userRepo.googleLogin();
      final profileDataModel = await userRepo.getProfile();
      final profile = _profileConverter.fromProfileData(profileDataModel);
      emit(LoginSuccessState(profile));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(LoginErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(LoginErrorState("Unable to login. Please try again"));
      }
    }
  }

  _onCredentialsLoginEvent(CredentialsLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      BudgetLogger.instance.d("login with credentials ${event.email}");
      await userRepo.credentialsLogin(event.email, event.password);
      final profileDataModel = await userRepo.getProfile();
      final profile = _profileConverter.fromProfileData(profileDataModel);
      emit(LoginSuccessState(profile));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(LoginErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        String message = "An expected error happened. Please try again";
        if (e.toString().contains("Invalid login credentials")) {
          message = "Incorrect email or password";
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
        String message = "Could not logout. Please try again";
        emit(LoginErrorState(message));
      }
    }
  }
}
