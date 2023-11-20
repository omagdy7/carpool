import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:intl/intl.dart';

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
        startLocation: 'Abassyia',
        endLocation: 'Abdu-Basha Gate-3'),
    Route(
        name: 'Afternoon Ride - Abdu-Basha to Gate 3',
        startLocation: 'Hadayek Elkoba',
        endLocation: 'Abdu-Basha Gate-6'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Routes')),
      body: ListView.builder(
        itemCount: dummyRoutes.length,
        itemBuilder: (BuildContext context, int index) {
          final Route route = dummyRoutes[index];
          return GestureDetector(
            onTap: () {
              DateTime now = DateTime.now();
              String formattedDateTime =
                  DateFormat('EEEE dd/MM/yyyy hh:mm a').format(now);
              Ride selectedRide = Ride(
                name: route.name,
                startLocation: route.startLocation,
                endLocation: route.endLocation,
                time: formattedDateTime, // Get current time
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(selectedRide: selectedRide),
                ),
              );
            },
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  route.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blue),
                        SizedBox(width: 4),
                        Flexible(child: Text(route.startLocation)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.arrow_forward, color: Colors.blue),
                        SizedBox(width: 4),
                        Flexible(child: Text(route.endLocation)),
                      ],
                    ),
                  ],
                ),
                leading: Icon(Icons.directions_car),
              ),
            ),
          );
        },
      ),
    );
  }
}
