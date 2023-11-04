import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';

class AppVersion extends AbstractSettingsTile {
  const AppVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: AppVersionValue(),
      // description:,
    );
  }
}

class AppVersionValue extends StatefulWidget {
  const AppVersionValue({Key? key}) : super(key: key);

  @override
  State<AppVersionValue> createState() => _AppVersionValueState();
}

class _AppVersionValueState extends State<AppVersionValue> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = 'Version ${info.version}(${info.buildNumber})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_version, style: TextStyle(fontSize: 14, color: AppColors.secondaryTextColor)),
      ],
    );
  }
}
