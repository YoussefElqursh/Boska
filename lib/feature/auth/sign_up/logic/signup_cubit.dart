import 'package:barber_app/core/storage/preference/shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void togglePasswordVisibility() {
    emit(PasswordVisibilityToggled(!state.isPasswordVisible));
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await SharedPreferenceHelper().saveUserId(userCredential.user!.uid);

      await SharedPreferenceHelper().saveUserName(name);

      await SharedPreferenceHelper().saveUserEmail(email);

      await SharedPreferenceHelper().saveUserImage('https://avatars.githubusercontent.com/u/79144849?s=400&u=6ee0ad0403f469ef76e43deb5e65e60a0c3aefd0&v=4');

      await _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email,
        'image': 'https://avatars.githubusercontent.com/u/79144849?s=400&u=6ee0ad0403f469ef76e43deb5e65e60a0c3aefd0&v=4',
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(state.copyWith(isLoading: false));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    }
  }
}