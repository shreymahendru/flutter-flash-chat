import 'package:flash_chat/main.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login/login_screen.dart';
import 'package:flash_chat/screens/registration/bloc/registration_bloc.dart';
import 'package:flash_chat/screens/registration/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/login/bloc/login_bloc.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case WelcomeScreen.id:
        return MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        );
      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              userRepository: RepositoryProvider.of(context),
              authenticationBloc: BlocProvider.of(context),
            ),
            child: LoginScreen(),
          ),
        );
      case RegistrationScreen.id:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RegistrationBloc>(
            create: (context) => RegistrationBloc(
              userRepository: RepositoryProvider.of(context),
              authenticationBloc: RepositoryProvider.of(context),
            ),
            child: RegistrationScreen(),
          ),
        );
      case ChatScreen.id:
        return MaterialPageRoute(
          builder: (context) => ChatScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
