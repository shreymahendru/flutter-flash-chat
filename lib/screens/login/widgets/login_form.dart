import 'package:flash_chat/components/rounded_buttons.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isValidationOn ? state.isFormValid && isPopulated && !state.isSubmitting: true;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          _showErorrSnackbar(context);
        }
        if (state.isSubmitting) {
          _showSubmittingSnackbar(context);
        }
        if (state.isSuccess) {
          print("login successful");
        }
      },
      builder: (context, state) => Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autovalidate: state.isValidationOn,
              validator: (_) => !state.isEmailValid ? "Invalid Email" : null,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Enter your Email",
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              autovalidate: state.isValidationOn,
              validator: (_) =>
                  !state.isPasswordValid ? "Invalid Password" : null,
              autocorrect: false,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Enter your Password",
              ),
            ),
            RoundedButton(
              label: "Log In",
              color: Colors.lightBlueAccent,
              onPressed: isLoginButtonEnabled(state) ? _onFormSubmitted : null,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErorrSnackbar(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Invalid Credentials"),
              Icon(Icons.error),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }

  void _showSubmittingSnackbar(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Logging in...",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
      );
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
