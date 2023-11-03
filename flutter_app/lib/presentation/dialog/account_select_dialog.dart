import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<AccountModel?> showAccountDialog(
  BuildContext context, {
  required AccountModel? selectedAccount,
  required String title,
  bool showEmpty = false,
  String emptyName = "All Accounts",
}) async {
  return await showDialog<AccountModel?>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: BlocBuilder<GraphViewBloc, GraphViewState>(
            builder: (blocContext, state) {
              List<AccountModel> accounts = [];
              if (state is GraphViewLoadedState) {
                accounts = state.bookModel.accounts;
              }
              return _buildContent(context, accounts, selectedAccount, showEmpty, emptyName);
            },
          ),
        );
      });
}

Widget _buildContent(
  BuildContext context,
  List<AccountModel> accounts,
  AccountModel? selectedAccount,
  bool showEmpty,
  String emptyName,
) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        if (showEmpty)
          ListTile(
            title: Text(emptyName),
            onTap: () {
              Navigator.pop(context, null);
            },
            leading: _RadioIcon(selected: selectedAccount == null),
          ),
        for (var account in accounts) ...[
          ListTile(
            title: Text(account.name ?? "Account"),
            onTap: () {
              Navigator.pop(context, account);
            },
            leading: _RadioIcon(selected: selectedAccount == account),
          ),
        ],
      ],
    ),
  );
}

class _RadioIcon extends StatelessWidget {
  final bool selected;

  const _RadioIcon({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.thirdTextColor,
          ),
          color: selected ? AppColors.accentColor : Colors.transparent,
        ),
        child: SizedBox.shrink());
    // child: selected ? Icon(Icons.check, color: Colors.white, size: 16.0) : null);
  }
}
