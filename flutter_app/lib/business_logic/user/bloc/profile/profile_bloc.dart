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
    BudgetLogger.instance.i("LoadProfileEvent");
    try {
      emit(ProfileLoadingState());
      final profileDataModel = await userRepo.getProfile();
      final profile = _profileConverter.fromProfileData(profileDataModel);
      BudgetLogger.instance.i(profile);
      emit(ProfileLoadedState(profile));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(ProfileErrorState("error.internet"));
      } else {
        BudgetLogger.instance.e(e);
        emit(ProfileErrorState("error.default"));
      }
    }
  }

  _onSetProfileEvent(SetProfileEvent event, Emitter<ProfileState> emit) async {
    BudgetLogger.instance.d("SetProfileEvent");
    emit(ProfileLoadedState(event.profile));
  }

  _onRemoveProfileEvent(RemoveProfileEvent event, Emitter<ProfileState> emit) async {
    BudgetLogger.instance.d("RemoveProfileEvent");
    emit(ProfileInitState());
  }
}
