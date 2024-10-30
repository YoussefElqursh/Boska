import 'package:barber_app/feature/onboarding/ui/onboarding_screen.dart';
import 'package:barber_app/feature/splash/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'SplashScreenRoute':
        return SplashScreen.route();
      case 'OnboardingScreenRoute':
        return OnboardingScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
      ),
    );
  }
}
