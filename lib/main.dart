import 'package:flutter/material.dart';
import 'routes.dart';
import 'login.dart';
import 'cart.dart';
import 'order_history.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carpool App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(), // Set the home page to a custom HomePage widget
      routes: {
        '/login': (context) => LoginPage(),
        '/routes': (context) => RoutesPage(),
        '/order_history': (context) => OrderHistoryPage(),
        '/cart': (context) => CartPage(
                selectedRide: Ride(
              name: 'Sample Ride',
              startLocation: 'Sample Start',
              endLocation: 'Sample End',
              time: 'Sample Time',
            )), // Assuming a sample ride is passed to the CartPage for testing
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Page for Testing'),
      ),
      body: Center(
        child: DropdownButton<String>(
          onChanged: (String? route) {
            if (route != null) {
              Navigator.pushNamed(context, route);
            }
          },
          items: <String>[
            '/login',
            '/routes',
            '/cart',
            '/order_history',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
