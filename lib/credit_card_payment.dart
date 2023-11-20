import 'package:flutter/material.dart';

class CreditCardDetailsPage extends StatelessWidget {
  final String orderID;

  CreditCardDetailsPage({required this.orderID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.credit_card,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Card Number',
                hintText: 'Enter your card number',
                prefixIcon: Icon(Icons.payment),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Expiration Date',
                hintText: 'MM/YYYY',
                prefixIcon: Icon(Icons.date_range),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'CVV',
                hintText: 'Enter CVV',
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Implement payment processing logic here
                // You can use the provided orderID to process payment
                print('Payment processed for Order ID: $orderID');
                Navigator.pop(
                    context); // Return to previous screen after payment
              },
              child: const Text('Submit Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
