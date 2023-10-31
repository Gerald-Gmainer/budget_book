part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitState extends AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState extends AccountState {
  final List<AccountModel> accounts;
  final AccountModel currentAccount;

  AccountLoadedState(this.accounts, this.currentAccount);
}

class AccountErrorState extends AccountState {
  final String message;

  AccountErrorState(this.message);
}
