part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class FieldValuesChanged extends RegistrationEvent {
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  const FieldValuesChanged({@required this.email, @required this.password});

  @override
  String toString() {
    return "FieldValuesChanged { email: $email, password: $password }";
  }
}

class ValidationStarted extends RegistrationEvent {
  @override
  String toString() {
    return "ValidationStarted";
  }
}

class RegistrationButtonPressed extends RegistrationEvent {
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  const RegistrationButtonPressed({
    @required this.email,
    @required this.password,
  });

  @override
  String toString() {
    return "RegistrationButtonPressed { email: $email, password: $password }";
  }
}
