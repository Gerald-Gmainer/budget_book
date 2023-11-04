import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';

import 'setting_chevron.dart';

class CurrencyButton extends AbstractSettingsTile {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String currency = "";
        if (state is ProfileLoadedState) {
          currency = state.profile.currency.name;
        }
        return SettingsTile.navigation(
          title: Text("Currency"),
          leading: Icon(FontAwesomeIcons.dollarSign, size: AppDimensions.settingIconSize),
          trailing: Text(currency),
          onPressed: (context) {},
        );
      },
    );
  }
}
