import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final BookingRepository repo;
  final AccountConverter _converter = AccountConverter();

  AccountBloc(this.repo) : super(AccountInitState()) {
    on<LoadAccountEvent>(_onLoadAccountEvent);
  }

  _onLoadAccountEvent(LoadAccountEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccountLoadingState());
      final accountDataModels = await repo.getAccounts();
      final accounts = _converter.fromDataModels(accountDataModels);
      final currentAccount = accounts[0];
      emit(AccountLoadedState(accounts, currentAccount));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(AccountErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(AccountErrorState("An error happened. Please try again"));
      }
    }
  }
}
