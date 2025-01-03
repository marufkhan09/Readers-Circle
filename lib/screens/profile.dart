import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/preferences_provider.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/widgets/buton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PrefProvider provider;
  SharedPref sharedPref = SharedPref();

  initState() {
    super.initState();
    provider = Provider.of<PrefProvider>(context, listen: false);
    provider.getSavedLoginResponse();
  }

  @override
  Widget build(BuildContext context) {
    var userData = provider.loginResponse.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout action
            },
          ),
        ],
      ),
      body: userData != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/profile.png'), // Add a profile picture asset
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '${userData!.firstName} ${userData.lastName}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(userData.email!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(userData.phoneNumber!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Account Type'),
                    subtitle: Text(userData.accountType!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('Preferences'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var preference in userData.preferences!)
                          Text('- $preference'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomActionButton(
                    onTap: () {
                      sharedPref.remove("isLoggedIn");
                      Navigator.pushReplacementNamed(
                          context, Routes.loginScreen);
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
