import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/auth_provider.dart';
import 'package:readers_circle/providers/book_provider.dart';
import 'package:readers_circle/providers/order_provider.dart';
import 'package:readers_circle/providers/preferences_provider.dart';
import 'package:readers_circle/providers/splash_provider.dart';
import 'package:readers_circle/utils/keys.dart';
import 'package:readers_circle/utils/route_observer.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/theme.dart';
import 'package:readers_circle/utils/routeNames.dart';

final MyRouteObserver routeObserver = MyRouteObserver();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    saveLocale: true,
    supportedLocales: const [Locale('en'), Locale('bn')],
    startLocale: const Locale("en"),
    fallbackLocale: const Locale("en"),
    path: 'assets/translations',
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => PrefProvider()),
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        navigatorKey: GlobalVariableKeys.navigatorState,
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: readersTheme(Brightness.light),
        initialRoute: Routes.splash,
        routes: routes,
      ),
    );
  }
}
