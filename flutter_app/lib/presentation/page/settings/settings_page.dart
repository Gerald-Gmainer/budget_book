import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/page/settings/widget/my_profile_button.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'widget/app_version.dart';
import 'widget/currency_button.dart';
import 'widget/logout_button.dart';
import 'widget/my_profile.dart';

class SettingsPage extends StatefulWidget {
  static const String route = "SettingsPage";

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final scaffoldProvider = Provider.of<ScaffoldProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Builder(builder: (ctx) {
        scaffoldProvider.setScaffoldContext((ctx));
        return Padding(
          padding: EdgeInsets.only(top: AppDimensions.verticalPadding),
          child: _buildSettings(context),
        );
      }),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return SettingsList(
      darkTheme: _getTheme(context),
      brightness: Brightness.dark,
      // platform: DevicePlatform.iOS,
      // contentPadding: EdgeInsets.zero,
      sections: [
        MyProfile(),
        SettingsSection(
          title: Text("General", style: TextStyle(fontWeight: FontWeight.bold)),
          tiles: [
            CurrencyButton(),
          ],
        ),
        SettingsSection(
          title: Text("Account", style: TextStyle(fontWeight: FontWeight.bold)),
          tiles: const [
            MyProfileButton(),
            LogoutButton(),
          ],
        ),
        SettingsSection(
          title: Text("Other", style: TextStyle(fontWeight: FontWeight.bold)),
          tiles: const [
            AppVersion(),
          ],
        )
      ],
    );
  }

  SettingsThemeData _getTheme(BuildContext context) {
    return SettingsThemeData(
      settingsListBackground: AppColors.primaryColor,
      // dividerColor: AppColors.errorColor,
      leadingIconsColor: AppColors.accentColor,
      // trailingTextColor: AppColors.errorColor,
      // inactiveTitleColor: AppColors.errorColor,
      settingsTileTextColor: AppColors.primaryTextColor,
      tileDescriptionTextColor: AppColors.secondaryTextColor,
      // tileHighlightColor: AppColors.errorColor,
      titleTextColor: AppColors.primaryTextColor,
      // inactiveSubtitleColor: AppColors.errorColor,
    );
  }
}
