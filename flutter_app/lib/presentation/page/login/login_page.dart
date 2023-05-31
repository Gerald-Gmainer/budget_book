import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  static const String route = "loginPage";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  _googleLogin() {
    BlocProvider.of<LoginBloc>(context).add(GoogleLoginEvent());
  }

  _credentialsLogin() {
    BlocProvider.of<LoginBloc>(context).add(CredentialsLoginEvent(_emailController.text, _passwordController.text));
  }

  _forgotPassword() {
    Navigator.of(context).pushNamed(ForgotPasswordPage.route);
  }

  _signUp() {
    Navigator.of(context).pushNamed(SignUpPage.route);
  }

  _onSuccess() {
    showSnackBar(context, "success");
    Navigator.of(context).pushNamedAndRemoveUntil(MainPage.route, (route) => false);
  }

  _onError(String message) {
    showErrorSnackBar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            _onSuccess();
          } else if (state is LoginErrorState) {
            _onError(state.message);
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(40.0),
                child: _buildForm(state is LoginLoadingState),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(bool isLoading) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppDimensions.verticalPadding),
        Text(AppLocalizations.of(context).login_sign_in_label),
        const SizedBox(height: AppDimensions.verticalPadding),
        _buildGoogleLogin(isLoading),
        const SizedBox(height: AppDimensions.verticalPadding),
        _buildDivider(),
        const SizedBox(height: AppDimensions.verticalPadding),
        _buildEmail(isLoading),
        const SizedBox(height: AppDimensions.verticalPadding),
        _buildPassword(isLoading),
        const SizedBox(height: AppDimensions.verticalPadding),
        _buildForgotPassword(isLoading),
        _buildLoginButton(isLoading),
        const SizedBox(height: AppDimensions.verticalPadding),
        _buildSignUp(isLoading),
        const SizedBox(height: AppDimensions.verticalPadding),
      ],
    );
  }

  Widget _buildGoogleLogin(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const FaIcon(FontAwesomeIcons.google),
        label: const Text("Google"),
        onPressed: isLoading ? null : _googleLogin,
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(margin: const EdgeInsets.only(right: 8), child: const Divider(color: Colors.white)),
        ),
        Text(AppLocalizations.of(context).login_continue_label),
        Expanded(
          child: Container(margin: const EdgeInsets.only(left: 8), child: const Divider(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildEmail(bool isLoading) {
    return TextFormField(
      controller: _emailController,
      readOnly: isLoading,
      validator: ValidationBuilder().email().build(),
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).login_email_input,
      ),
    );
  }

  Widget _buildPassword(bool isLoading) {
    return TextFormField(
      controller: _passwordController,
      readOnly: isLoading,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).login_password_input,
      ),
      validator: ValidationBuilder().required().build(),
    );
  }

  Widget _buildLoginButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : _credentialsLogin,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          elevation: 3,
        ),
        child: Text(AppLocalizations.of(context).login_login_button),
      ),
    );
  }

  Widget _buildForgotPassword(bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: isLoading ? null : _forgotPassword,
          child: Text(AppLocalizations.of(context).login_forgot_password_button),
        ),
      ],
    );
  }

  Widget _buildSignUp(bool isLoading) {
    return TextButton(
      onPressed: isLoading ? null : _signUp,
      child: Text(AppLocalizations.of(context).login_sign_up_button),
    );
  }
}
