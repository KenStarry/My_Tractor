import 'package:flutter/material.dart';

class TractorCard extends StatelessWidget {
  final String ownerName;
  final VoidCallback onClick;

  const TractorCard(
      {super.key, required this.ownerName, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 4, blurRadius: 4)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/tractor.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(height: 8),
              Text(
                ownerName,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
