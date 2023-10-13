import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tractor/core/presentation/components/custom_radio.dart';

import '../../../core/presentation/components/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                    hint: 'Email Address',
                    iconData: Icons.email_rounded,
                    textStyle: Theme.of(context).textTheme.bodyMedium!,
                    onChanged: (value) {}),
                CustomTextField(
                    hint: 'Phone Number',
                    iconData: Icons.email_rounded,
                    textStyle: Theme.of(context).textTheme.bodyMedium!,
                    onChanged: (value) {}),
                CustomTextField(
                    hint: 'New Password',
                    iconData: Icons.key_rounded,
                    textStyle: Theme.of(context).textTheme.bodyMedium!,
                    onChanged: (value) {}),
                CustomTextField(
                    hint: 'Confirm Password',
                    iconData: Icons.key_rounded,
                    textStyle: Theme.of(context).textTheme.bodyMedium!,
                    onChanged: (value) {}),

                //  check if they own a tractor or want to hire one
                Text("I want to : "),

                Column(
                  children: [
                    CustomRadio(
                        title: 'Hire a Tractor',
                        value: '',
                        groupValue: '',
                        onTap: () {},
                        onChanged: (value) {}),
                    CustomRadio(
                        title: 'Publish my tractor',
                        value: '',
                        groupValue: '',
                        onTap: () {},
                        onChanged: (value) {})
                  ],
                ),

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
