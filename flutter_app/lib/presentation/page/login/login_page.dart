import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String route = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(InitLoginEvent());
    if (!kReleaseMode) {
      _emailController.text = "gerald_gmainer@designium.jp";
      _passwordController.text = "aaaaaaA1";
    }
  }

  _googleLogin() {
    BlocProvider.of<LoginBloc>(context).add(GoogleLoginEvent());
  }

  _credentialsLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    BlocProvider.of<LoginBloc>(context).add(CredentialsLoginEvent(_emailController.text, _passwordController.text));
  }

  _forgotPassword() {
    Navigator.of(context).pushNamed(ForgotPasswordPage.route);
  }

  _signUp() {
    Navigator.of(context).pushNamed(SignUpPage.route);
  }

  _onSuccess(ProfileModel profile) {
    BlocProvider.of<ProfileBloc>(context).add(SetProfileEvent(profile));
    Navigator.of(context).pushNamedAndRemoveUntil(MainPage.route, (route) => false);
  }

  _onError(String message) {
    showErrorSnackBar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldProvider = Provider.of<ScaffoldProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("login.title".tr())),
      body: Builder(builder: (ctx) {
        scaffoldProvider.setScaffoldContext((ctx));

        return BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              _onSuccess(state.profile);
            } else if (state is LoginErrorState) {
              _onError(state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                width: AppDimensions.formWidth,
                padding: AppDimensions.formPadding,
                child: Column(
                  children: [
                    Image.asset('assets/logo.png', height: 100),
                    const SizedBox(height: 20),
                    _buildForm(state is LoginLoadingState),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildForm(bool isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("login.sign_with_label".tr()),
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
      ),
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
        Text("login.or_continue_with_label".tr()),
        Expanded(
          child: Container(margin: const EdgeInsets.only(left: 8), child: const Divider(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildEmail(bool isLoading) {
    return FormInputText(
      controller: _emailController,
      label: "login.email".tr(),
      validator: ValidationBuilder().email().build(),
      isLoading: isLoading,
    );
  }

  Widget _buildPassword(bool isLoading) {
    return FormInputPassword(
      controller: _passwordController,
      label: "login.password".tr(),
      validator: ValidationBuilder().required().build(),
      isLoading: isLoading,
    );
  }

  Widget _buildLoginButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: FormButton(
        text: "login.login_button".tr(),
        onPressed: _credentialsLogin,
        isLoading: isLoading,
      ),
    );
  }

  Widget _buildForgotPassword(bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: isLoading ? null : _forgotPassword,
          child: Text("login.forgot_password_label".tr()),
        ),
      ],
    );
  }

  Widget _buildSignUp(bool isLoading) {
    return TextButton(
      onPressed: isLoading ? null : _signUp,
      child: Text("login.dont_have_account_label".tr()),
    );
  }
}
