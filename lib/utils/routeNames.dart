import 'package:flutter/material.dart';
import 'package:readers_circle/screens/bkash/bkash_payment.dart';
import 'package:readers_circle/screens/bkash/confirmation_page.dart';
import 'package:readers_circle/screens/book_details.dart';
import 'package:readers_circle/screens/checkout.dart';
import 'package:readers_circle/screens/dashboard.dart';
import 'package:readers_circle/screens/login.dart';
import 'package:readers_circle/screens/preferences.dart';
import 'package:readers_circle/screens/profile.dart';
import 'package:readers_circle/screens/register.dart';
import 'package:readers_circle/screens/rentlist.dart';
import 'package:readers_circle/screens/search.dart';
import 'package:readers_circle/screens/selling_list.dart';
import 'package:readers_circle/screens/splash.dart';
import 'package:readers_circle/screens/upload_book.dart';
import 'package:readers_circle/utils/routes.dart';

var routes = {
  Routes.splash: (context) => const SplashScreen(),
  Routes.loginScreen: (context) => const LoginScreen(),
  Routes.register: (context) => const RegisterScreen(),
  Routes.preferences: (context) => const PreferencesScreen(),
  Routes.dashboard: (context) => const DashboardScreen(),
  Routes.profile: (context) => const ProfileScreen(),
  Routes.bookDetail: (context) => BookDetailsScreen(
        id: ModalRoute.of(context)!.settings.arguments as String,
      ),
  Routes.sellinglist: (context) => const SellingListScreen(),
  Routes.rentinglist: (context) => const RentListScreen(),
  Routes.search: (context) => const SearchPage(),
  Routes.uploadBook: (context) => const UploadBookScreen(),
  Routes.bkash: (context) => PaymentScreen(
        data:
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
      ),
  Routes.confirmation: (context) => const ConfirmationScreen(),
  Routes.checkout: (context) => CheckoutPage(
      args: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
};
