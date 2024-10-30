import 'package:barber_app/feature/auth/admin_login/logic/admin_login_cubit.dart';
import 'package:barber_app/feature/auth/login/logic/login_cubit.dart';
import 'package:barber_app/feature/auth/login/ui/login_screen.dart';
import 'package:barber_app/feature/auth/sign_up/logic/signup_cubit.dart';
import 'package:barber_app/feature/home/ui/home_screen.dart';
import 'package:barber_app/feature/splash/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'feature/auth/first_login/first_login_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => AdminLoginCubit(),
        ),
        BlocProvider(
          create: (context) => FirstLoginCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xFF2B1615),
            surfaceTintColor: Colors.transparent,
          ),
          scaffoldBackgroundColor: const Color(0xFF2B1615),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2B1615),
          ),
          useMaterial3: true,
        ),
        home: BlocBuilder<FirstLoginCubit, FirstLoginState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            } else if (state is AuthUnauthenticated) {
              return LoginScreen();
            } else {
              return const SplashScreen();  // Loading screen while checking status
            }
          },
        ),
      ),
    );
  }
}
