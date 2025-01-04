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
  late PrefProvider prefProvider;
  SharedPref sharedPref = SharedPref();

  initState() {
    super.initState();
    prefProvider = Provider.of<PrefProvider>(context, listen: false);
    prefProvider.getSavedLoginResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: context.watch<PrefProvider>().userResponseLoaded
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/images/profile.png'), // Add a profile picture asset
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '${context.watch<PrefProvider>().loginResponse.data!.firstName} ${context.watch<PrefProvider>().loginResponse.data!.lastName}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(context
                        .watch<PrefProvider>()
                        .loginResponse
                        .data!
                        .email!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(context
                        .watch<PrefProvider>()
                        .loginResponse
                        .data!
                        .phoneNumber!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Account Type'),
                    subtitle: Text(context
                        .watch<PrefProvider>()
                        .loginResponse
                        .data!
                        .accountType!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('Preferences'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var preference in context
                            .watch<PrefProvider>()
                            .loginResponse
                            .data!
                            .preferences!)
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
