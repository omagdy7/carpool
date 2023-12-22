import 'package:carpool/drawer.dart';
import 'package:carpool/ride_request.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// Accessing Firestore instance
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class Route {
  final String name;
  final String startLocation;
  final String endLocation;
  final String carBrand;
  final String carModel;
  final String carColor;
  final String plateNumber;
  final String status;
  final DateTime orderTime;

  Route({
    required this.name,
    required this.startLocation,
    required this.endLocation,
    required this.carBrand,
    required this.carModel,
    required this.carColor,
    required this.plateNumber,
    required this.status,
    required this.orderTime,
  });
}

Color getColorFromString(String color) {
  switch (color.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'pink':
      return Colors.pink;
    case 'cyan':
      return Colors.cyan;
    case 'silver':
      return Colors.grey;
    // You can add more cases for additional colors as needed
    default:
      // Return a default color if the input doesn't match any specified colors
      return Colors.black;
  }
}

Future<List<Route>> getDataFromFirestore() async {
  List<Route> routes = [];
  try {
    // Accessing a specific collection ('users' in this case)
    QuerySnapshot querySnapshot = await firestore.collection('Rides').get();

    // Loop through the documents in the collection
    querySnapshot.docs
        .where((element) => element['status'] == 'Unreserved')
        .forEach((doc) {
      String name = doc['driverName'];
      String fromLocation = doc['fromLocation'];
      String toLocation = doc['toLocation'];
      String carModel = doc['carModel'];
      String carBrand = doc['carBrand'];
      String carColor = doc['carColor'];
      String plateNumber = doc['plateNumber'];
      String status = doc['status'];
      Timestamp orderTime = doc['orderTime'];
      routes.add(Route(
        name: name,
        startLocation: fromLocation,
        endLocation: toLocation,
        carModel: carModel,
        carBrand: carBrand,
        carColor: carColor,
        plateNumber: plateNumber,
        status: status,
        orderTime: orderTime.toDate(),
      ));
    });
  } catch (e) {
    print('Error retrieving data: $e');
  }
  return routes;
}

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      drawer: const CustomDrawer(),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (BuildContext context, int index) {
          final Route route = routes[index];
          return GestureDetector(
            onTap: () {
              DateTime now = DateTime.now();
              Ride selectedRide = Ride(
                  name: route.name,
                  startLocation: route.startLocation,
                  endLocation: route.endLocation,
                  carModel: route.carModel,
                  carBrand: route.carBrand,
                  carColor: route.carColor,
                  plateNumber: route.plateNumber,
                  status: route.status,
                  orderTime: route.orderTime);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RequestRidePage(selectedRide: selectedRide),
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
                    Row(
                      children: [
                        Icon(Icons.directions_car,
                            color: getColorFromString(route.carColor)),
                        const SizedBox(width: 4),
                        Text('${route.carBrand} - ${route.carModel}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.confirmation_number,
                            color: Colors.blue),
                        const SizedBox(width: 4),
                        Text('Plate: ${route.plateNumber}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.info, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text('Status: ${route.status}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.schedule, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(DateFormat('EEEE dd/MM/yyyy hh:mm a')
                            .format(route.orderTime)),
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
