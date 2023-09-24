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
      appBar: AppBar(title: Text("Budget Book")),
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
            Text("Success", style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: AppDimensions.verticalPadding),
            Text(
              "Check your inbox to verify your email address",
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
      label: "Email",
      validator: ValidationBuilder().email().build(),
    );
  }

  Widget _buildPassword() {
    return FormInputText(
      controller: _passwordController,
      label: "Password",
      validator: ValidationBuilder().password().build(),
      obscureText: true,
    );
  }

  Widget _buildConfirmPassword() {
    return FormInputText(
      controller: _passwordConfirmController,
      label: "Confirm Password",
      validator: ValidationBuilder().required().build(),
      obscureText: true,
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: FormButton(
        text: "Sign Up",
        onPressed: _signUp,
      ),
    );
  }
}
