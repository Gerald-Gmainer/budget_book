import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountFilter extends StatefulWidget {
  @override
  State<AccountFilter> createState() => _AccountFilterState();
}

class _AccountFilterState extends State<AccountFilter> {
  // String _selectedValue = "All Accounts";
  AccountModel? _selectedAccount;

  Future<void> _showAccountDialog() async {
    AccountModel? selectedAccount = await showAccountDialog(
      context,
      selectedAccount: _selectedAccount,
      title: "Display Account",
      showEmpty: true,
    );

    setState(() {
      _selectedAccount = selectedAccount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.verticalPadding / 2,
        horizontal: AppDimensions.horizontalPadding,
      ),
      child: InkWell(
        onTap: _showAccountDialog,
        child: InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding),
            border: OutlineInputBorder(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _selectedAccount == null ? "All Accounts" : (_selectedAccount!.name ?? "Account"),
                style: TextStyle(color: AppColors.secondaryTextColor, fontSize: 14),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
