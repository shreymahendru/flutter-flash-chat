part of 'registration_bloc.dart';

@immutable
class RegistrationState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isValidationOn;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  @override
  List<Object> get props => [
        isEmailValid,
        isPasswordValid,
        isValidationOn,
        isSubmitting,
        isSuccess,
        isFailure,
      ];

  bool get isFormValid => !isValidationOn || (isEmailValid && isPasswordValid);

  const RegistrationState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isValidationOn,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegistrationState.initial() {
    return RegistrationState(
      isEmailValid: true,
      isPasswordValid: true,
      isValidationOn: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory RegistrationState.submitting() {
    return RegistrationState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      isValidationOn: true,
    );
  }

  factory RegistrationState.failure() {
    return RegistrationState(
      isEmailValid: true,
      isPasswordValid: true,
      isValidationOn: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegistrationState.success() {
    return RegistrationState(
      isEmailValid: true,
      isPasswordValid: true,
      isValidationOn: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegistrationState updateFieldValidation(
      {bool isEmailValid, bool isPasswordValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegistrationState startValidation() {
    return copyWith(
      isValidationOn: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegistrationState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isValidationOn,
  }) {
    return RegistrationState(
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
    return '''RegistrationState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isValidationOn: $isValidationOn
    }''';
  }
}
