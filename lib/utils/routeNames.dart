import 'package:readers_circle/screens/dashboard.dart';
import 'package:readers_circle/screens/login.dart';
import 'package:readers_circle/screens/preferences.dart';
import 'package:readers_circle/screens/profile.dart';
import 'package:readers_circle/screens/register.dart';
import 'package:readers_circle/screens/splash.dart';
import 'package:readers_circle/utils/routes.dart';

var routes = {
  Routes.splash: (context) => const SplashScreen(),
  Routes.loginScreen: (context) => const LoginScreen(),
  Routes.register: (context) => const RegisterScreen(),
  Routes.preferences: (context) => const PreferencesScreen(),
  Routes.dashboard: (context) => const DashboardScreen(),
  Routes.profile: (context) => const ProfileScreen(),
};
