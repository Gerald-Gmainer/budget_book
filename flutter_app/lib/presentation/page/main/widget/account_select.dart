import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class AccountSelect extends StatefulWidget {
  @override
  State<AccountSelect> createState() => _AccountSelectState();
}

class _AccountSelectState extends State<AccountSelect> {
  String _selectedValue = "All Accounts";

  Future<void> _showAccountDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Display Accounts'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (String account in ["All Accounts", "Account1", "Account2"]) ...[
                  ListTile(
                    title: Text(account),
                    leading: Radio<String>(
                      value: account,
                      groupValue: _selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
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
                _selectedValue,
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
