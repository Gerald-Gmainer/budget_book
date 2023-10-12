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
      final response = await userRepo.googleLogin();


      if (response) {
        final currencyDataModels = await userRepo.getCurrencies();
        final profileDataModel = await userRepo.getProfile();
        final profileSettingDataModel = await userRepo.getProfileSetting();

        final profile = _profileConverter.fromProfileData(profileDataModel);
        final profileSetting = _profileConverter.fromProfileSettingData(profileSettingDataModel, currencyDataModels);

        emit(LoginSuccessState(profile, profileSetting));
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
      final currencyDataModels = await userRepo.getCurrencies();
      final profileDataModel = await userRepo.getProfile();
      final profileSettingDataModel = await userRepo.getProfileSetting();

      final profile = _profileConverter.fromProfileData(profileDataModel);
      final profileSetting = _profileConverter.fromProfileSettingData(profileSettingDataModel, currencyDataModels);

      if (response) {
        emit(LoginSuccessState(profile, profileSetting));
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
