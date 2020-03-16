import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flash_chat/common/authentication/bloc/authentication_bloc.dart';
import 'package:flash_chat/common/validators.dart';
import 'package:flash_chat/repositories/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  UserRepository _userRepository;
  AuthenticationBloc _authenticationBloc;

  @override
  RegistrationState get initialState => RegistrationState.initial();

  RegistrationBloc(
      {@required UserRepository userRepository,
      @required AuthenticationBloc authenticationBloc}) {
    assert(userRepository != null);
    _userRepository = userRepository;

    assert(authenticationBloc != null);
    _authenticationBloc = authenticationBloc;
  }

  @override
  Stream<RegistrationState> transformEvents(
    Stream<RegistrationEvent> events,
    Stream<RegistrationState> Function(RegistrationEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! FieldValuesChanged);
    });

    final debounceStream = events.where((event) {
      return (event is FieldValuesChanged);
    }).debounceTime(
      Duration(milliseconds: 300),
    ); // only let the event go to mapEventToState when 300 miliseconds have passed!

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is FieldValuesChanged) {
      yield* _validateFields(event.email, event.password);
    } else if (event is RegistrationButtonPressed) {
      yield* _registrationButtonPressed(event.email, event.password);
    }
  }

  Stream<RegistrationState> _validateFields(
      String email, String password) async* {
    yield state.updateFieldValidation(
      isEmailValid: Validators.isValidEmail(email),
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegistrationState> _registrationButtonPressed(email, password) async* {
    final startValidation = state.startValidation();
    yield startValidation;
    if (!startValidation.isFormValid) return;

    yield RegistrationState.submitting();
    try {
      await _userRepository.signUp(email: email, password: password);
      yield RegistrationState.success();
      _authenticationBloc.add(LoggedIn());
    } catch (e) {
      yield RegistrationState.failure();
      print(e);
    }
  }
}
