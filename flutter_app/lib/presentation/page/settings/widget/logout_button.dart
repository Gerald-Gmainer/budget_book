import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'setting_chevron.dart';

class LogoutButton extends AbstractSettingsTile {
  const LogoutButton({Key? key}) : super(key: key);

  Future<void> _onLogout(BuildContext context) async {
    ConfirmDialog.show(
      context,
      headerText: "logout.dialog.title",
      bodyText: "logout.dialog.body",
      onOK: () {
        _logout(context);
      },
    );
  }

  _logout(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
    Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      title: Text("settings.logout_button".tr()),
      leading: Icon(FontAwesomeIcons.arrowRightFromBracket, color: AppColors.warningColor, size: AppDimensions.settingIconSize),
      trailing: SettingChevron(),
      onPressed: (context) {
        _onLogout(context);
      },
    );
  }
}
