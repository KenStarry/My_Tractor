import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tractor/core/presentation/components/custom_textfield.dart';
import 'package:my_tractor/feature_sign_up/presentation/components/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Login", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              CustomTextField(
                  hint: 'Email Address',
                  iconData: Icons.email_rounded,
                  textStyle: Theme.of(context).textTheme.bodyMedium!,
                  onChanged: (value) {}),
              CustomTextField(
                  hint: 'Password',
                  iconData: Icons.key_rounded,
                  textStyle: Theme.of(context).textTheme.bodyMedium!,
                  onChanged: (value) {}),
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text("Login")),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text.rich(TextSpan(children: [
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                      text: "Create an account",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => SignUp());
                        })
                ])),
              )
            ],
          )),
        ),
      ),
    );
  }
}
