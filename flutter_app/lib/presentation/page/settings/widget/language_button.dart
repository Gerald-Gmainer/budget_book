import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageButton extends AbstractSettingsTile {
  _onTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("language.dialog.title".tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("language.en".tr()),
                onTap: () {
                  _changeLanguage(context, Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("language.de".tr()),
                onTap: () {
                  _changeLanguage(context, Locale('de'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _changeLanguage(BuildContext context, Locale locale) {
    context.setLocale(locale);
    BlocProvider.of<LanguageBloc>(context).add(SetLanguageEvent(locale));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String value = "";
        if (state is LanguageLoadedState) {
          value = state.locale.languageCode;
        }
        return SettingsTile(
          title: Text("language.name".tr()),
          leading: Icon(FontAwesomeIcons.dollarSign, size: AppDimensions.settingIconSize),
          trailing: Text("language.$value").tr(),
          onPressed: (context) {
            _onTap(context);
          },
        );
      },
    );
  }
}
