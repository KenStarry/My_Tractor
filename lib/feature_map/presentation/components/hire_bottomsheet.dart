import 'package:flutter/material.dart';

import '../../../core/domain/model/user_model.dart';

class HireBottomSheet extends StatelessWidget {
  final UserModel user;

  const HireBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/tractor.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                )),
          ),

          const SizedBox(height: 16),

          Text(user.fullName!, style: Theme.of(context).textTheme.titleSmall),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        "Hire Tractor",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontWeight,
                            color: Colors.white),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
