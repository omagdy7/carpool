import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart.dart';
import 'package:intl/intl.dart';

// Accessing Firestore instance
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class Route {
  final String name;
  final String startLocation;
  final String endLocation;

  Route(
      {required this.name,
      required this.startLocation,
      required this.endLocation});
}

Future<List<Route>> getDataFromFirestore() async {
  List<Route> routes = [];
  try {
    // Accessing a specific collection ('users' in this case)
    QuerySnapshot querySnapshot = await firestore.collection('Rides').get();

    // Loop through the documents in the collection
    querySnapshot.docs.forEach((doc) {
      String name = doc['driverName'];
      // String carModel = doc['carModel'];
      // String carColor = doc['carColor'];
      // String plateNumber = doc['plateNumber'];
      // String status = doc['status'];
      // DateTime orderTime = doc['orderTime'];
      String fromLocation = doc['fromLocation'];
      String toLocation = doc['toLocation'];
      routes.add(Route(
          name: name, startLocation: fromLocation, endLocation: toLocation));
    });
  } catch (e) {
    print('Error retrieving data: $e');
  }
  return routes;
}

class RoutesPage extends StatefulWidget {
  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  List<Route> routes = [];

  @override
  void initState() {
    super.initState();
    fetchRoutesFromFirestore();
  }

  Future<void> fetchRoutesFromFirestore() async {
    List<Route> fetchedRoutes = await getDataFromFirestore();
    setState(() {
      routes = fetchedRoutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Routes')),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (BuildContext context, int index) {
          final Route route = routes[index];
          return GestureDetector(
            onTap: () {
              DateTime now = DateTime.now();
              String formattedDateTime =
                  DateFormat('EEEE dd/MM/yyyy hh:mm a').format(now);
              Ride selectedRide = Ride(
                name: route.name,
                startLocation: route.startLocation,
                endLocation: route.endLocation,
                time: formattedDateTime,
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
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  route.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        const SizedBox(width: 4),
                        Flexible(child: Text(route.startLocation)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: Colors.blue),
                        const SizedBox(width: 4),
                        Flexible(child: Text(route.endLocation)),
                      ],
                    ),
                  ],
                ),
                leading: const Icon(Icons.directions_car),
              ),
            ),
          );
        },
      ),
    );
  }
}
