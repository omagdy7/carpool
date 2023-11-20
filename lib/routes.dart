import 'package:flutter/material.dart';

class Route {
  final String name;
  final String startLocation;
  final String endLocation;

  Route(
      {required this.name,
      required this.startLocation,
      required this.endLocation});
}

class RoutesPage extends StatelessWidget {
  final List<Route> dummyRoutes = [
    Route(
        name: 'Morning Ride - Gate 3 to Abdu-Basha',
        startLocation: 'Gate 3',
        endLocation: 'Abdu-Basha'),
    Route(
        name: 'Afternoon Ride - Abdu-Basha to Gate 3',
        startLocation: 'Abdu-Basha',
        endLocation: 'Gate 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Routes')),
      body: ListView.builder(
        itemCount: dummyRoutes.length,
        itemBuilder: (BuildContext context, int index) {
          final Route route = dummyRoutes[index];
          return ListTile(
            title: Text(route.name),
            subtitle:
                Text('From: ${route.startLocation} - To: ${route.endLocation}'),
            onTap: () {
              // Handle route selection here, if needed
              print('Selected route: ${route.name}');
            },
          );
        },
      ),
    );
  }
}
