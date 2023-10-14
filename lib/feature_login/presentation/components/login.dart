import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tractor/core/domain/model/response_state.dart';
import 'package:my_tractor/core/presentation/components/custom_textfield.dart';
import 'package:my_tractor/feature_sign_up/presentation/components/sign_up.dart';
import 'package:my_tractor/feature_tractor_owner_home/presentation/tractor_owner_home.dart';

import '../../../core/presentation/controller/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final GlobalKey<FormState> _formKey;
  late final AuthController _authController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _authController = Get.find<AuthController>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Login", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              CustomTextField(
                  hint: 'Email Address',
                  controller: _emailController,
                  iconData: Icons.email_rounded,
                  textStyle: Theme.of(context).textTheme.bodyMedium!,
                  onValidate: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }

                    return 'Email cannot be empty';
                  },
                  onChanged: (value) {}),
              CustomTextField(
                  hint: 'Password',
                  controller: _passwordController,
                  iconData: Icons.key_rounded,
                  textStyle: Theme.of(context).textTheme.bodyMedium!,
                  onValidate: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }

                    return 'Password cannot be empty';
                  },
                  onChanged: (value) {}),
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _authController.signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                              response: (state, error) {
                                switch (state) {
                                  case ResponseState.success:
                                    Get.to(() => const TractorOwnerHome());
                                    break;
                                  case ResponseState.loading:
                                    break;
                                  case ResponseState.failure:
                                    print("ERROR : ${error!}");
                                    break;
                                }
                              });
                        }
                      },
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
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => const SignUp());
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
