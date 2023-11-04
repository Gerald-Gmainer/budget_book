import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const String route = "SignUpPage";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  AutovalidateMode? _autovalidateMode;

  @override
  initState() {
    super.initState();
    BlocProvider.of<SignUpBloc>(context).add(InitSignUpEvent());
    if (!kReleaseMode) {
      _emailController.text = "gerald_gmainer@designium.jp";
      _passwordController.text = "aaaaaaA1";
      _passwordConfirmController.text = "aaaaaaA1";
    }
  }

  _signUp() {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    BlocProvider.of<SignUpBloc>(context).add(SignUpNowEvent(_emailController.text, _passwordController.text));
  }

  _onError(String message) {
    showErrorSnackBar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldProvider = Provider.of<ScaffoldProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("sign_up.title".tr())),
      body: Builder(builder: (ctx) {
        scaffoldProvider.setScaffoldContext((ctx));

        return BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpErrorState) {
              _onError(state.message);
            }
          },
          builder: (context, state) {
            scaffoldProvider.setScaffoldContext((context));

            if (state is SignUpLoadingState) {
              return _buildLoading();
            }
            if (state is SignUpSuccessState) {
              return _buildSuccess();
            }
            return _buildForm();
          },
        );
      }),
    );
  }

  Widget _buildForm() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: AppDimensions.formWidth,
          padding: AppDimensions.formPadding,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppDimensions.verticalPadding),
                _buildEmail(),
                const SizedBox(height: AppDimensions.verticalPadding),
                _buildPassword(),
                const SizedBox(height: AppDimensions.verticalPadding),
                _buildConfirmPassword(),
                const SizedBox(height: AppDimensions.verticalPadding),
                _buildSignUpButton(),
                const SizedBox(height: AppDimensions.verticalPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccess() {
    return Center(
      child: Container(
        width: AppDimensions.formWidth,
        padding: AppDimensions.formPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("sign_up.success".tr(), style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: AppDimensions.verticalPadding),
            Text(
              "sign_up.success_detail".tr(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return FormInputText(
      controller: _emailController,
      label: "login.email".tr(),
      autovalidateMode: _autovalidateMode,
      validator: ValidationBuilder().email().build(),
    );
  }

  Widget _buildPassword() {
    return FormInputPassword(
      controller: _passwordController,
      label: "login.password".tr(),
      autovalidateMode: _autovalidateMode,
      validator: ValidationBuilder().password().build(),
    );
  }

  Widget _buildConfirmPassword() {
    return FormInputPassword(
      controller: _passwordConfirmController,
      label: "login.confirm_password".tr(),
      autovalidateMode: _autovalidateMode,
      validator: ValidationBuilder().required().match(_passwordController).build(),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: FormButton(
        text: "sign_up.sign_up_button".tr(),
        onPressed: _signUp,
      ),
    );
  }
}
