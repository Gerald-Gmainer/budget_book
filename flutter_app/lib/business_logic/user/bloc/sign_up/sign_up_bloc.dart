import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepo;

  SignUpBloc(this.userRepo) : super(SignUpInitState()) {
    on<InitSignUpEvent>(_onInitSignUpEvent);
    on<SignUpNowEvent>(_onSignUpNowEvent);
  }

  _onInitSignUpEvent(InitSignUpEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpInitState());
  }

  _onSignUpNowEvent(SignUpNowEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(SignUpLoadingState());
      BudgetLogger.instance.d("signUp ${event.email}");
      await userRepo.signUp(event.email, event.password);
      emit(SignUpSuccessState());
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(SignUpErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(SignUpErrorState("Unable to sign up. Please try again"));
      }
    }
  }
}
