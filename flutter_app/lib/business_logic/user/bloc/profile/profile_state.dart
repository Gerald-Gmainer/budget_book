part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profile;

  ProfileLoadedState(this.profile);
}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState(this.message);
}
