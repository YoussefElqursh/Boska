import 'package:firebase_auth/firebase_auth.dart';

// Login States
abstract class LoginState {}

class LoginInitial extends LoginState {
  final bool isPasswordVisible;
  LoginInitial({this.isPasswordVisible = false});
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class LoginPasswordVisibilityChanged extends LoginState {
  final bool isPasswordVisible;
  LoginPasswordVisibilityChanged(this.isPasswordVisible);
}