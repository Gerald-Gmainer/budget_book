import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSelectInput extends StatefulWidget {
  final BookingModel model;

  const AccountSelectInput({required this.model});

  @override
  State<AccountSelectInput> createState() => _AccountSelectInputState();
}

class _AccountSelectInputState extends State<AccountSelectInput> {
  _onTap(List<AccountModel> accounts) async {
    AccountModel? selectedAccount = await showAccountDialog(context, selectedAccount: widget.model.account, title: "Select an Account");

    if (selectedAccount != null) {
      setState(() {
        widget.model.account = selectedAccount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphViewBloc, GraphViewState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            List<AccountModel> accounts = [];
            if (state is GraphViewLoadedState) {
              accounts = state.bookModel.accounts;
            }
            _onTap(accounts);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            // color: Colors.red,
            child: Icon(IconConverter.getIconFromModel(widget.model.account?.iconData), size: 28),
          ),
        );
      },
    );
  }
}
