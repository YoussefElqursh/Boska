import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'first_login_state.dart';

class FirstLoginCubit extends Cubit<FirstLoginState> {
  FirstLoginCubit() : super(FirstLoginInitial());

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    emit(AuthUnauthenticated());
  }
}
