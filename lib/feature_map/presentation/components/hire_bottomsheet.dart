import 'package:flutter/material.dart';

import '../../../core/domain/model/user_model.dart';

class HireBottomSheet extends StatelessWidget {

  final UserModel user;

  const HireBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.all(16),
    );
  }
}
