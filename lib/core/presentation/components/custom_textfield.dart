import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final TextStyle textStyle;
  final int? maxLines;
  final bool isObscured;
  final bool isEnabled;
  final bool? showErrorMessage;
  final bool? readOnly;
  final bool? showCursor;
  final String? errorMessage;
  final String? value;
  final TextInputType inputType;
  final TextEditingController? controller;
  final Function(String text) onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? onValidate;

  const CustomTextField(
      {super.key,
      required this.hint,
      required this.iconData,
      required this.textStyle,
      this.maxLines = 1,
      this.isObscured = false,
      this.isEnabled = true,
      this.showErrorMessage,
      this.readOnly,
      this.showCursor,
      this.errorMessage,
      this.value,
      this.inputType = TextInputType.text,
      this.controller,
      required this.onChanged,
      this.onTap,
      this.onValidate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          autofocus: false,
          controller: controller,
          enabled: isEnabled,
          obscureText: isObscured,
          keyboardType: inputType,
          maxLines: maxLines,
          readOnly: readOnly ?? false,
          showCursor: showCursor ?? true,
          textInputAction: TextInputAction.done,
          style: TextStyle(fontSize: 18, color: Colors.black),
          cursorColor: Theme.of(context).primaryColor,
          onTap: onTap,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: textStyle,
              enabled: isEnabled,
              icon: Icon(
                iconData,
                color: Theme.of(context).primaryColor,
              ),
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              fillColor: Theme.of(context).primaryColorDark.withOpacity(0.1),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: Theme.of(context).primaryColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.1))),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.1)))),
          validator: onValidate,
          onChanged: onChanged,
        ),

        const SizedBox(height: 24),

        //  error message
        Visibility(
            visible: showErrorMessage != null &&
                showErrorMessage! == true,
            child: Row(
              children: [
                const Icon(
                  Icons.error_rounded,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  errorMessage ?? "",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                )
              ],
            ))
      ],
    );
  }
}
