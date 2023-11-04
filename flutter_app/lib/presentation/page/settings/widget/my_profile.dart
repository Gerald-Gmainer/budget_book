import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

class MyProfile extends AbstractSettingsSection {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.bodyText1;
    final descStyle = Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          ProfileModel profile = state.profile;
          return SettingsSection(
            tiles: [
              SettingsTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: headerStyle),
                    if (profile.email != null) Text(profile.email!, maxLines: 1, overflow: TextOverflow.ellipsis, style: descStyle),
                  ],
                ),
                leading: Container(
                  transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
                  width: 65,
                  child: Icon(
                    Icons.account_circle,
                    color: AppColors.secondaryTextColor,
                    size: 70,
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
