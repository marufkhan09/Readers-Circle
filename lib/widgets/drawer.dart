import 'package:flutter/material.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/shared_pref.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  SharedPref sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Readers Circle',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Borrow List'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, Routes.borrowlist); // Navigate
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Order List'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/order-list'); // Navigate
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Add logout functionality here
              sharedPref.remove("isLoggedIn");
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            },
          ),
        ],
      ),
    );
  }
}
