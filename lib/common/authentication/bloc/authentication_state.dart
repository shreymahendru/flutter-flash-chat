part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String displayName;

  const AuthenticationAuthenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'AuthenticationAuthenticated { displayName: $displayName }';
}

class AuthenticationUnauthenticated extends AuthenticationState {}
