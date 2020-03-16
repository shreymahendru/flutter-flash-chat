import 'package:flash_chat/components/rounded_buttons.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/registration/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationBloc _registrationBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegistrationState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    _emailController.addListener(_onFieldValuesChanged);
    _passwordController.addListener(_onFieldValuesChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            buildRegistrationForm(context),
          ],
        ),
      ),
    );
  }

  Widget buildRegistrationForm(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.isFailure) {
          print("error");
          _showErorrSnackbar(context);
        }
        if (state.isSubmitting) {
          _showSubmittingSnackbar(context);
        }
        if (state.isSuccess) {
          print("registeered");
        }
      },
      builder: (context, state) {
        return Form(
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
                label: "Register",
                color: Colors.lightBlueAccent,
                onPressed: state.isFormValid ? _onFormSubmitted : null,
              )
            ],
          ),
        );
      },
    );
  }

  void _showErorrSnackbar(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("An error occured..."),
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
                "Registering...",
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

  void _onFieldValuesChanged() {
    _registrationBloc.add(
      FieldValuesChanged(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    _registrationBloc.add(
      RegistrationButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
