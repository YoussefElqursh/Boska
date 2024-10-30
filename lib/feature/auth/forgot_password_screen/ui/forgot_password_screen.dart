import 'package:barber_app/core/widget/common_btn_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? email;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent. Check your email'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(
                  color: Color(0xFFDF711A),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.2,
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
                  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.2,
              ),
              buildMaterialButton(
                context: context,
                label: 'Reset Password',
                color: const Color(0xFFDF711A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                    });
                    resetPassword();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
