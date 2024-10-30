import 'package:barber_app/core/widget/common_btn_widget.dart';
import 'package:barber_app/feature/auth/login/ui/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const String routeName = 'OnboardingScreenRoute';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OnboardingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 120.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/barber.png'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
            ),
            buildMaterialButton(
              context: context,
              color: const Color(0xFFDF711A),
              label: 'Get a Stylish Haircut',
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
