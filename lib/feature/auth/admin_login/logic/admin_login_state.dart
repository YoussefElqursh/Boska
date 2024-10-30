// Login States
abstract class AdminLoginState {}

class AdminLoginInitial extends AdminLoginState {
  final bool isPasswordVisible;
  AdminLoginInitial({this.isPasswordVisible = false});
}

class AdminLoginLoading extends AdminLoginState {}

class AdminLoginSuccess extends AdminLoginState {}

class AdminLoginFailure extends AdminLoginState {
  final String error;
  AdminLoginFailure(this.error);
}

class AdminLoginPasswordVisibilityChanged extends AdminLoginState {
  final bool isPasswordVisible;
  AdminLoginPasswordVisibilityChanged(this.isPasswordVisible);
}