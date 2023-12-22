import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Define a Ride class to represent the selected ride
class Ride {
  final String name;
  final String startLocation;
  final String endLocation;
  final String carBrand;
  final String carModel;
  final String carColor;
  final String plateNumber;
  final String status;
  final DateTime orderTime;

  Ride({
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

class RequestRidePage extends StatelessWidget {
  final Ride selectedRide;

  RequestRidePage({required this.selectedRide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Selected Ride:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.directions_car, color: Colors.blue),
                  title: Text(selectedRide.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(selectedRide.startLocation),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.arrow_forward, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(selectedRide.endLocation),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    User? user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      String userId = user.uid;
                      print("UserId: ${userId}");
                      CollectionReference collection =
                          firestore.collection('RideRequest');

                      Map<String, dynamic> data = {
                        'dropOff': selectedRide.endLocation,
                        'pickUp': selectedRide.startLocation,
                        'status': "Pending",
                        'passengerID': userId,
                      };

                      try {
                        // Add a new document with an automatically generated ID
                        await collection.add(data);
                        print('Document added successfully!');
                      } catch (e) {
                        print('Error adding document: $e');
                      }
                    }

                    print('Processing Requesting Ride');
                  },
                  child: const Text('Request Ride'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
