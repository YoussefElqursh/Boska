import 'package:barber_app/core/helper/app_regex.dart';
import 'package:barber_app/feature/auth/admin_login/logic/admin_login_cubit.dart';
import 'package:barber_app/feature/auth/admin_login/logic/admin_login_state.dart';
import 'package:barber_app/feature/dashboard/ui/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});

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
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 30.0,
                    )),
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
                    'Admin Login',
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
                child: BlocListener<AdminLoginCubit, AdminLoginState>(
                  listener: (context, state) {
                    if (state is AdminLoginSuccess) {
                      // Handle successful login
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login Successfully")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                        ),
                      );
                    } else if (state is AdminLoginFailure) {
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
                        BlocBuilder<AdminLoginCubit, AdminLoginState>(
                          builder: (context, state) {
                            bool isPasswordVisible = false;
                            if (state is AdminLoginPasswordVisibilityChanged) {
                              isPasswordVisible = state.isPasswordVisible;
                            } else if (state is AdminLoginInitial) {
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
                                        .read<AdminLoginCubit>()
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
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03,
                        ),
                        BlocBuilder<AdminLoginCubit, AdminLoginState>(
                          builder: (context, state) {
                            return MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  final email = emailController.text;
                                  final password = passwordController.text;
                                  context
                                      .read<AdminLoginCubit>()
                                      .adminLogin(email, password);
                                }
                              },
                              color: Colors.white,
                              padding: const EdgeInsets.all(10.0),
                              minWidth: MediaQuery.sizeOf(context).width,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: state is AdminLoginLoading
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
