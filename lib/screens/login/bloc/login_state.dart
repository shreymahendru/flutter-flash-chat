part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isValidationOn;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  List<Object> get props => [
        isEmailValid,
        isPasswordValid,
        isValidationOn,
        isSubmitting,
        isSuccess,
        isFailure
      ];

  const LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isValidationOn,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory LoginState.initial() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isValidationOn: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory LoginState.submitting() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      isValidationOn: true,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isValidationOn: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isValidationOn: true,
    );
  }

  LoginState updateFieldValidation({bool isEmailValid, bool isPasswordValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState startValidation() {
    return copyWith(isValidationOn: true);
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isValidationOn,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isValidationOn: isValidationOn ?? this.isValidationOn,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isValidationOn: $isValidationOn
    }''';
  }
}

// class LoginInitial extends LoginState {
//   @override
//   List<Object> get props => [];
// }
