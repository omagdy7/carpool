import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'credit_card_payment.dart';

class Order {
  final String pickUp;
  final String dropOff;
  final String status;
  final double amount;

  Order({
    required this.pickUp,
    required this.dropOff,
    required this.status,
    required this.amount,
  });
}

class PaymentOrderTrackingPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment & Order Tracking'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final Order order = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CreditCardDetailsPage(orderID: "13251231254"),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ride: ${order.pickUp} - ${order.dropOff}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            'Status: ${order.status}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            'Amount: \$${order.amount.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      leading: const Icon(Icons.payment),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Order>> _fetchOrders() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final passengerID = currentUser.uid;

      QuerySnapshot rideRequests = await _firestore
          .collection('RideRequest')
          .where('passengerID', isEqualTo: passengerID)
          .get();

      List<Order> orders = [];
      rideRequests.docs.forEach((doc) {
        String pickUp = doc['pickUp'];
        String dropOff = doc['dropOff'];
        String status = doc['status'];

        Order order = Order(
          pickUp: pickUp,
          dropOff: dropOff,
          status: status,
          amount: 50,
        );
        orders.add(order);
      });
      return orders;
    } else {
      return [];
    }
  }
}
