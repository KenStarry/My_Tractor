import 'package:flutter/material.dart';

class TractorOwnerHome extends StatefulWidget {
  const TractorOwnerHome({super.key});

  @override
  State<TractorOwnerHome> createState() => _TractorOwnerHomeState();
}

class _TractorOwnerHomeState extends State<TractorOwnerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("I'm Home"),
      )),
    );
  }
}
