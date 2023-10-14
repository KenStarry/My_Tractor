import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tractor/core/domain/model/user_model.dart';
import 'package:my_tractor/core/presentation/components/custom_radio.dart';
import 'package:my_tractor/core/presentation/controller/auth_controller.dart';

import '../../../core/presentation/components/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final AuthController _authController;
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Create Account",
            style: Theme.of(context).textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    CustomTextField(
                        hint: 'Full Name',
                        controller: _fullNameController,
                        iconData: Icons.person_rounded,
                        textStyle: Theme.of(context).textTheme.bodyMedium!,
                        onValidate: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }

                          return 'Name cannot be empty!';
                        },
                        onChanged: (value) {}),
                    CustomTextField(
                        hint: 'Email Address',
                        controller: _emailController,
                        iconData: Icons.email_rounded,
                        textStyle: Theme.of(context).textTheme.bodyMedium!,
                        onValidate: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }

                          return 'Enter a valid email address';
                        },
                        onChanged: (value) {}),
                    CustomTextField(
                        hint: 'Phone Number',
                        controller: _phoneController,
                        iconData: Icons.phone_rounded,
                        textStyle: Theme.of(context).textTheme.bodyMedium!,
                        onValidate: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }

                          return 'Enter a valid phone number';
                        },
                        onChanged: (value) {}),
                    CustomTextField(
                        hint: 'New Password',
                        iconData: Icons.key_rounded,
                        textStyle: Theme.of(context).textTheme.bodyMedium!,
                        isObscured: true,
                        inputType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        onValidate: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }

                          return 'Enter a valid password';
                        },
                        onChanged: (value) {}),
                    CustomTextField(
                        hint: 'Confirm Password',
                        iconData: Icons.key_rounded,
                        controller: _confirmPasswordController,
                        textStyle: Theme.of(context).textTheme.bodyMedium!,
                        isObscured: true,
                        inputType: TextInputType.visiblePassword,
                        onValidate: (value) {
                          if (value == _passwordController.text) {
                            return null;
                          }

                          return 'Passwords do not match';
                        },
                        onChanged: (value) {}),

                    //  check if they own a tractor or want to hire one
                    const Text("I want to : "),

                    Column(
                      children: [
                        Obx(
                          () => CustomRadio(
                              title: 'Hire a Tractor',
                              value: 'Hire',
                              groupValue:
                                  _authController.selectedUserType.value,
                              onTap: () {
                                _authController.setSelectedUserType(
                                    userType: 'Hire');
                              },
                              onChanged: (value) {
                                _authController.setSelectedUserType(
                                    userType: value);
                              }),
                        ),
                        Obx(
                          () => CustomRadio(
                              title: 'Publish my tractor',
                              value: 'Publish',
                              groupValue:
                                  _authController.selectedUserType.value,
                              onTap: () {
                                _authController.setSelectedUserType(
                                    userType: 'Publish');
                              },
                              onChanged: (value) {
                                _authController.setSelectedUserType(
                                    userType: value);
                              }),
                        )
                      ],
                    ),

                    const SizedBox(height: 16),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Container(
                        width: double.infinity,
                        child: FilledButton(
                            onPressed: () async {
                              //  create user in firestore
                              if (_formKey.currentState!.validate() &&
                                  _authController.selectedUserType.value !=
                                      null) {
                                final user = UserModel(
                                    fullName: _fullNameController.text,
                                    email: _emailController.text,
                                    phoneNumber: _phoneController.text,
                                    userType:
                                        _authController.selectedUserType.value);

                                await _authController.createAccount(
                                    userModel: user,
                                    password: _passwordController.text,
                                    response: (state, error) {});
                              }
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16)),
                            child: const Text("Create account")),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
