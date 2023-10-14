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
      appBar: AppBar(
        title: Text("Requests", style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.7),
          label: Row(
            children: [
              Icon(Icons.location_on_rounded,
                  color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text("Ping Location",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          Theme.of(context).textTheme.bodyMedium!.fontWeight,
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium!.fontSize))
            ],
          )),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("I'm Home"),
      )),
    );
  }
}
