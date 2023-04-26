import 'package:flutter/material.dart';
import 'package:mama_resto/screens/splash_screen.dart';

import 'screens/home_screen.dart';
import 'theme_manager/theme_data_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donor Kuy',
      theme: getApplicationThemeData(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
