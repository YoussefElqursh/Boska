import 'package:barber_app/core/helper/Extension/functions.dart';
import 'package:barber_app/core/helper/app_regex.dart';
import 'package:barber_app/feature/auth/admin_login/ui/admin_login_screen.dart';
import 'package:barber_app/feature/auth/forgot_password_screen/ui/forgot_password_screen.dart';
import 'package:barber_app/feature/auth/login/logic/login_cubit.dart';
import 'package:barber_app/feature/auth/login/logic/login_state.dart';
import 'package:barber_app/feature/auth/login/logic/login_with_google.dart';
import 'package:barber_app/feature/auth/sign_up/ui/sign_up_screen.dart';
import 'package:barber_app/feature/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminLoginScreen(),
                    ),
                  );
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Admin Panel',
                    style: TextStyle(
                      color: Color(0xFFDF711A),
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Black and White Modern Illustrative Barbershop Logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Let\'s Login',
                    style: TextStyle(
                      color: Color(0xFFDF711A),
                      fontSize: 48.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFDF711A),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: BlocListener<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      // Handle successful login
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login Successfully")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    } else if (state is LoginFailure) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${state.error}")),
                      );
                    }
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            await signInWithGoogle().then((value) {
                              debugPrint(value.user!.uid);
                            }).catchError((error) {
                              debugPrint(error);
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          color: Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          minWidth: MediaQuery.sizeOf(context).width,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              setPhoto(
                                kind: 1,
                                path: 'assets/images/google.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              const Text(
                                'Google',
                                style: TextStyle(
                                  color: Color(0xFF2B1615),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.05,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.0,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.05,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            label: Text(
                              'Email',
                              style: TextStyle(
                                color: Color(0xFF2B1615),
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Color(0xFF2B1615),
                            ),
                          ),
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            final emailRegex =
                                RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03,
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            bool isPasswordVisible = false;
                            if (state is LoginPasswordVisibilityChanged) {
                              isPasswordVisible = state.isPasswordVisible;
                            } else if (state is LoginInitial) {
                              isPasswordVisible = state.isPasswordVisible;
                            }
                            return TextFormField(
                              controller: passwordController,
                              obscureText: !isPasswordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                if (AppRegex.isPasswordValidStrong(value)) {
                                  return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                label: const Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Color(0xFF2B1615),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF2B1615),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<LoginCubit>()
                                        .togglePasswordVisibility();
                                  },
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: const Color(0xFF2B1615),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF2B1615),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  final email = emailController.text;
                                  final password = passwordController.text;
                                  context
                                      .read<LoginCubit>()
                                      .loginWithEmail(email, password);
                                }
                              },
                              color: Colors.white,
                              padding: const EdgeInsets.all(10.0),
                              minWidth: MediaQuery.sizeOf(context).width,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: state is LoginLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Color(0xFF2B1615),
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF2B1615),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
