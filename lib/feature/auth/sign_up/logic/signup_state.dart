part of 'signup_cubit.dart';

class SignupState {
  final bool isPasswordVisible;
  final bool isLoading;
  final String? errorMessage;


  SignupState({
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
  });

  SignupState copyWith({bool? isPasswordVisible, bool? isLoading, String? errorMessage}) {
    return SignupState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure(this.error);
}

class PasswordVisibilityToggled extends SignupState {
  PasswordVisibilityToggled(bool isVisible) : super(isPasswordVisible: isVisible);
}
