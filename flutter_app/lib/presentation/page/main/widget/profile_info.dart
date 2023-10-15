import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          final name = state.profile.name;
          final email = state.profile.email;
          final avatarUrl = state.profile.avatarUrl;
          return _buildInfo(name, email, avatarUrl != null ? _buildAvatar(avatarUrl) : _buildEmptyPicture());
        }
        return _buildInfo("Name", "Email", _buildEmptyPicture());
      },
    );
  }

  _buildInfo(String name, String? email, Widget picture) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: AppColors.accentColor),
      accountName: Text(name, style: TextStyle(fontSize: 22, color: AppColors.primaryTextColor)),
      accountEmail: email != null ? Text(email, style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor)) : null,
      currentAccountPicture: picture,
    );
  }

  Widget _buildAvatar(String url) {
    throw "TODO build avatar widget";
  }

  Widget _buildEmptyPicture() {
    return CircleAvatar(
      backgroundColor: AppColors.secondaryTextColor,
      child: Icon(
        Icons.person,
        size: 48,
      ),
    );
  }
}
