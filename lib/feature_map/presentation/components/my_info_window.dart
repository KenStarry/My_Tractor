import 'package:flutter/material.dart';

class MyInfoWindow extends StatelessWidget {
  const MyInfoWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/tractor.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                )),
          ),

          Text("Starry", style: Theme.of(context).textTheme.bodyLarge),

          TextButton(onPressed: (){},
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColorDark,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor
              ),
              child: Text(
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
                color: Theme.of(context).primaryColorDark),
          ))
        ],
      ),
    );
  }
}
