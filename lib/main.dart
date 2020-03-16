import 'package:flash_chat/common/authentication/bloc/authentication_bloc.dart';
import 'package:flash_chat/repositories/user_repository/firebase_user_repository.dart';
import 'package:flash_chat/repositories/user_repository/user_repository.dart';
import 'package:flash_chat/router.dart';
import 'package:flash_chat/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // is required in Flutter v1.9.4+ before using any plugins if the code is executed before runApp.]=
  BlocSupervisor.delegate = SimpleBlocDelegate();
  // final UserRepository userRepository = FirebaseUserRepository();

  runApp(RepositoryProvider<UserRepository>(
    create: (context) => FirebaseUserRepository(),
    child: BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      )..add(AppStarted()),
      child: FlashChat(),
    ),
  ));
}

class FlashChat extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print(_navigatorKey.hashCode);
        print(state);
        if (state is AuthenticationAuthenticated) {
          _navigatorKey.currentState.pushReplacementNamed(ChatScreen.id);
          return;
        }
        if (state is AuthenticationUnauthenticated) {
          _navigatorKey.currentState.pushReplacementNamed(WelcomeScreen.id);
          return;
        }
        if (state is AuthenticationUninitialized) {
          _navigatorKey.currentState.pushReplacementNamed(SplashScreen.id);
        }
      },
      child: MaterialApp(
        // theme: ThemeData.dark().copyWith(
        //   textTheme: TextTheme(
        //     body1: TextStyle(color: Colors.black54),
        //   ),
        // ),
        navigatorKey: _navigatorKey,
        initialRoute: SplashScreen.id,
        onGenerateRoute: Router.generateRoute,
        // routes: {
        //   SplashScreen.id: (context) => SplashScreen(),
        //   WelcomeScreen.id: (context) => WelcomeScreen(),
        //   LoginScreen.id: (context) => LoginScreen(),
        //   RegistrationScreen.id: (context) => RegistrationScreen(),
        //   ChatScreen.id: (context) => ChatScreen()
        // },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  static const id = "splash_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}
