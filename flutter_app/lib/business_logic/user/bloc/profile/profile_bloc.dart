import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepo;
  final ProfileConverter _profileConverter = ProfileConverter();

  ProfileBloc(this.userRepo) : super(ProfileInitState()) {
    on<LoadProfileEvent>(_onLoadProfileEvent);
    on<SetProfileEvent>(_onSetProfileEvent);
    on<RemoveProfileEvent>(_onRemoveProfileEvent);
  }

  _onLoadProfileEvent(LoadProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      final currencyDataModels = await userRepo.getCurrencies();
      final profileDataModel = await userRepo.getProfile();
      final profileSettingDataModel = await userRepo.getProfileSetting();

      final profile = _profileConverter.fromProfileData(profileDataModel);
      final profileSetting = _profileConverter.fromProfileSettingData(profileSettingDataModel, currencyDataModels);
      emit(ProfileLoadedState(profile, profileSetting));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(ProfileErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(ProfileErrorState("TODO error message"));
      }
    }
  }

  _onSetProfileEvent(SetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadedState(event.profile, event.profileSetting));
  }

  _onRemoveProfileEvent(RemoveProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInitState());
  }
}
