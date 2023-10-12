part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class SetProfileEvent extends ProfileEvent {
  final ProfileModel profile;
  final ProfileSettingModel profileSetting;

  SetProfileEvent(this.profile, this.profileSetting);
}

class RemoveProfileEvent extends ProfileEvent {}
