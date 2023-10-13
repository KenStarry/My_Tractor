import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class CustomRadio extends StatelessWidget {
  final String title;
  final String value;
  final String? groupValue;
  final VoidCallback onTap;
  final Function(String?)? onChanged;

  const CustomRadio(
      {super.key,
      required this.title,
      required this.value,
      required this.groupValue,
        required this.onTap,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(
        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
        fontWeight: Theme.of(context).textTheme.bodyLarge!.fontWeight,
        color: groupValue == value ? accent : Theme.of(context).textTheme.bodyLarge!.color
      ),),
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(horizontal: 0),
      onTap: onTap,
      leading:
          Radio(value: value, groupValue: groupValue, activeColor: Theme.of(context).primaryColor, onChanged: onChanged),
    );
  }
}
