import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class SettingChevron extends StatelessWidget {
  const SettingChevron({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.chevron_right, color: AppColors.secondaryTextColor);
  }
}
