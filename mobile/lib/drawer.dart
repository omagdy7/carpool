import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            icon: Icons.app_registration_rounded,
            text: 'Signup',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/signup');
            },
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
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/routes');
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
          _buildDrawerItem(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onTap: () {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
          _buildDrawerItem(
            icon: Icons.history,
            text: 'Order History',
            onTap: () {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/order_history');
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
          _buildDrawerItem(
            icon: Icons.payment,
            text: 'Payment & Order Tracking',
            onTap: () {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/payment');
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
