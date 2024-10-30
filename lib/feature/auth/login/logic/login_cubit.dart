import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginCubit() : super(LoginInitial());

  Future<void> loginWithEmail(String email, String password) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      emit(LoginSuccess(userCredential.user!));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  void togglePasswordVisibility() {
    // Get current visibility state and toggle it
    final currentState = state;
    bool isVisible = false;
    if (currentState is LoginPasswordVisibilityChanged) {
      isVisible = currentState.isPasswordVisible;
    } else if (currentState is LoginInitial) {
      isVisible = currentState.isPasswordVisible;
    }
    emit(LoginPasswordVisibilityChanged(!isVisible));
  }

}