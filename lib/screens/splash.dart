import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/auth_provider.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  late AuthProvider provider;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
     sharedPref.clear();
    provider = Provider.of<AuthProvider>(context, listen: false);
    provider.checkIfLoggedin().then(
      (value) async {
        if (value) {
          var prefCount = await sharedPref.readInt("preferences") ?? 0;
          if (prefCount > 0) {
            Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacementNamed(context, Routes.dashboard),
            );
          } else {
            Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacementNamed(context, Routes.preferences),
            );
          }
        } else {
          Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacementNamed(context, Routes.loginScreen),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Image.asset("assets/images/icon.png"),
        ),
      ),
    );
  }
}
