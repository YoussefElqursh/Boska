import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_login_state.dart';

class AdminLoginCubit extends Cubit<AdminLoginState> {
  AdminLoginCubit() : super(AdminLoginInitial());

  void adminLogin(String email, String password) async {
    emit(AdminLoginLoading());
    try {
      FirebaseFirestore.instance.collection('Admin').get().then((
          QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc['email'] != email) {
            emit(AdminLoginFailure('No user found for that email.'));
          }
          else if (doc['password'] != password) {
            emit(AdminLoginFailure('Wrong password provided for that user.'));
          }
          else if (doc['email'] == email && doc['password'] == password) {
            emit(AdminLoginSuccess());
          } else {
            emit(AdminLoginFailure('No user found for that email.'));
          }
        }
      });
      emit(AdminLoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AdminLoginFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AdminLoginFailure('Wrong password provided for that user.'));
      } else {

      }
    }
  }

    void togglePasswordVisibility() {
      // Get current visibility state and toggle it
      final currentState = state;
      bool isVisible = false;
      if (currentState is AdminLoginPasswordVisibilityChanged) {
        isVisible = currentState.isPasswordVisible;
      } else if (currentState is AdminLoginInitial) {
        isVisible = currentState.isPasswordVisible;
      }
      emit(AdminLoginPasswordVisibilityChanged(!isVisible));
    }
  }