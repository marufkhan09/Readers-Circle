import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/models/login_response/login_response.dart';
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
  
  LoginResponse? _loginResponse;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<AuthProvider>(context, listen: false).checkIfLoggedin().then(
      (value) async {
        if (value) {
      var jsonString =await  sharedPref.readObject("loginResponse") ?? null;
        _loginResponse = json.decode((jsonString));

        if(_loginResponse!.data!.preferences!.isNotEmpty){
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        }else{

        }

          Timer(
            const Duration(seconds: 3),
            (){
              
            },
          );
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
