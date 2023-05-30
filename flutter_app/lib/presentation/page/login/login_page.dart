import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String route = "loginPage";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "login ",
          // style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
