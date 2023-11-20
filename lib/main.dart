import 'package:flutter/material.dart';
import 'routes.dart';
import 'login.dart';
import 'cart.dart';
import 'payement_order.dart';
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
        '/payment': (context) => PaymentOrderTrackingPage(),
        '/cart': (context) => CartPage(
                selectedRide: Ride(
              name: 'Sample Ride',
              startLocation: 'Sample Start',
              endLocation: 'Sample End',
              time: 'Sample Time',
            )),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.login,
              text: 'Login',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
            ),
            _buildDrawerItem(
              icon: Icons.map,
              text: 'Routes',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/routes');
              },
            ),
            _buildDrawerItem(
              icon: Icons.shopping_cart,
              text: 'Cart',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
            ),
            _buildDrawerItem(
              icon: Icons.history,
              text: 'Order History',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/order_history');
              },
            ),
            _buildDrawerItem(
              icon: Icons.payment,
              text: 'Payment & Order Tracking',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/payment');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Welcome to Carpool App!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
