import 'package:flutter/material.dart';
import 'routes.dart';
import 'login.dart';

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
      initialRoute: '/routes', // Set the initial route to the login page
      routes: {
        '/login': (context) => LoginPage(),
        '/routes': (context) => RoutesPage(),
      },
    );
  }
}
