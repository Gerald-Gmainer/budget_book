import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_setting_event.dart';
part 'profile_setting_state.dart';

class ProfileSettingBloc extends Bloc<ProfileSettingEvent, ProfileSettingState> {
  ProfileSettingBloc() : super(ProfileSettingInitial()) {
    on<ProfileSettingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
