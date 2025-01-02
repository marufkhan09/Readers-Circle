import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/login_provider.dart';
import 'package:readers_circle/utils/colors.dart';
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
    Provider.of<LoginProvider>(context, listen: false).checkIfLoggedin().then(
      (value) {
        if (value) {
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushReplacementNamed(context,Routes.dashboard),
          );
        } else {
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushReplacementNamed(context,Routes.loginScreen),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text(
            "App Setup Splash",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: CustomColors.white),
          ),
        ),
      ),
    );
  }
}
