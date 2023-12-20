import 'package:flutter/material.dart';
import 'credit_card_payment.dart';

class Order {
  final String orderID;
  final String rideName;
  final String status;
  final double amount;

  Order(
      {required this.orderID,
      required this.rideName,
      required this.status,
      required this.amount});
}

class PaymentOrderTrackingPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
        orderID: '001',
        rideName: 'Morning Ride - Gate 3 to Abdu-Basha',
        status: 'Completed',
        amount: 15.0),
    Order(
        orderID: '002',
        rideName: 'Afternoon Ride - Abdu-Basha to Gate 3',
        status: 'Pending',
        amount: 12.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment & Order Tracking'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          final Order order = orders[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreditCardDetailsPage(orderID: order.orderID),
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
                  'Order ID: ${order.orderID}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ride: ${order.rideName}'),
                    Text('Status: ${order.status}'),
                    Text('Amount: \$${order.amount.toStringAsFixed(2)}'),
                  ],
                ),
                leading: Icon(Icons
                    .payment), // TODO Use an appropriate icon for payment/order tracking
              ),
            ),
          );
        },
      ),
    );
  }
}
