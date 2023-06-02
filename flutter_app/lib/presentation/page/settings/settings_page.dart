import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const String route = "SettingsPage";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _logout() {
    BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
    Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldProvider = Provider.of<ScaffoldProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Builder(builder: (ctx) {
        scaffoldProvider.setScaffoldContext((ctx));

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _logout, child: const Text("logout")),
            ],
          ),
        );
      }),
    );
  }
}
