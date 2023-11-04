import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';

import 'setting_chevron.dart';

class MyProfileButton extends AbstractSettingsTile {
  const MyProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      title: Text("settings.my_profile".tr()),
      leading: Icon(FontAwesomeIcons.userGear, size: AppDimensions.settingIconSize),
      trailing: SettingChevron(),
      onPressed: (context) {},
    );
  }
}
