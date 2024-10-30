import 'package:barber_app/core/helper/Extension/functions.dart';
import 'package:barber_app/core/helper/app_regex.dart';
import 'package:barber_app/feature/auth/login/ui/login_screen.dart';
import 'package:barber_app/feature/auth/sign_up/logic/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, Let\'s Sign Up',
                    style: TextStyle(
                      color: Color(0xFFDF711A),
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
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
                child: BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    } else if (state.isLoading) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Loading...')),
                      );
                    } else if (state.errorMessage == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account Created Successfully')),
                      );
                    }
                  },
                  builder: (context, state) {

                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          MaterialButton(
                            onPressed: () {},
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
                            controller: nameController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              label: Text(
                                'Name',
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
                                Icons.person_outline,
                                color: Color(0xFF2B1615),
                              ),
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              if (value.length < 3) {
                                return 'Name must be at least 3 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03,
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
                          BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return TextFormField(
                                controller: passwordController,
                                obscureText: !state.isPasswordVisible,
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
                                          .read<SignupCubit>()
                                          .togglePasswordVisibility();
                                    },
                                    icon: Icon(
                                      state.isPasswordVisible
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
                          BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              if (state is SignupLoading) {
                                return const CircularProgressIndicator();
                              }
                              return MaterialButton(
                                onPressed: state.isLoading ? null : () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final email = emailController.text.trim();
                                    final password =
                                        passwordController.text.trim();
                                    final name = nameController.text.trim();
                                    context.read<SignupCubit>().signup(
                                        email: email,
                                        password: password,
                                        name: name);
                                  }
                                },
                                color: Colors.white,
                                padding: const EdgeInsets.all(10.0),
                                minWidth: MediaQuery.sizeOf(context).width,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: state.isLoading ?
                                const CircularProgressIndicator()
                                    :
                                const Text(
                                  'Create Account',
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
                                'Already have an account?',
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
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
