import 'package:flutter/material.dart';

// Define a Ride class to represent the selected ride
class Ride {
  final String name;
  final String startLocation;
  final String endLocation;
  final String time;

  Ride({
    required this.name,
    required this.startLocation,
    required this.endLocation,
    required this.time,
  });
}

class CartPage extends StatelessWidget {
  final Ride selectedRide;

  CartPage({required this.selectedRide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
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
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(selectedRide.time),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement payment or confirmation logic here
                    // For now, just print a message
                    print('Processing payment/confirmation...');
                  },
                  child: const Text('Proceed to Payment/Confirm'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
