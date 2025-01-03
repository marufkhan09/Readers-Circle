import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/auth_provider.dart';
import 'package:readers_circle/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<AuthProvider>(context, listen: false).checkIfLoggedin().then(
      (value) {
        if (value) {
          Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacementNamed(context,Routes.dashboard),
          );
        } else {
          Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacementNamed(context,Routes.loginScreen),
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
