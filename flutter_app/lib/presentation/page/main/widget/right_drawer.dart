import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RightDrawer extends StatelessWidget {
  const RightDrawer({super.key});

  _openSettings(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed(SettingsPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.accentColor,
              ),
              accountName: Text(
                "name",
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.primaryTextColor,
                ),
              ),
              accountEmail: Text(
                "email",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryTextColor,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColors.secondaryTextColor,
                // child: Icon(
                //   FontAwesomeIcons.user,
                //   size: 48,
                // ),
                child: Icon(
                  Icons.person,
                  size: 48,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                _openSettings(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
