import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flash_chat/common/authentication/bloc/authentication_bloc.dart';
import 'package:flash_chat/common/validators.dart';
import 'package:flash_chat/repositories/user_repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  AuthenticationBloc _authenticationBloc;

  // LoginBloc({
  //   @required UserRepository userRepository,
  //   @required AuthenticationBloc authenticationBloc
  // })  : assert(userRepository != null),
  //       _userRepository = userRepository,
  //       assert(authenticationBloc != null),
  //       _authenticationBloc = authenticationBloc;

  LoginBloc(
      {@required UserRepository userRepository,
      @required AuthenticationBloc authenticationBloc}) {
    assert(userRepository != null);
    _userRepository = userRepository;

    assert(authenticationBloc != null);
    _authenticationBloc = authenticationBloc;
  }

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> transformEvents(
    // called before mapEventToState on events
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(
      Duration(milliseconds: 300),
    ); // only let the event go to mapEventToState when 300 miliseconds have passed!

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _emailChanged(event.email);
    } else if (event is PasswordChanged) {
      yield* _passwordChanged(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _loginWithCredentialsPressed(event.email, event.password);
    }
  }

  Stream<LoginState> _emailChanged(String email) async* {
    yield state.updateFieldValidation(
        isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _passwordChanged(String password) async* {
    yield state.updateFieldValidation(isPasswordValid: password.isNotEmpty);
  }

  Stream<LoginState> _loginWithCredentialsPressed(
      String email, String password) async* {
    yield state.startValidation();
    print(state);
    if (!state.isFormValid) {
      return;
    }

    yield LoginState.submitting();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
      _authenticationBloc.add(LoggedIn());
    } catch (e) {
      print(e);
      yield LoginState.failure();
    }
  }
}
