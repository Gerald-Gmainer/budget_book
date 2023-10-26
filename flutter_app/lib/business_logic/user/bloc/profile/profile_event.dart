part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class SetProfileEvent extends ProfileEvent {
  final ProfileModel profile;

  SetProfileEvent(this.profile);
}

class RemoveProfileEvent extends ProfileEvent {}
