import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/features/restaurant/cubit/favorite_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/notification_cubit.dart';
import 'package:mama_resto/screens/detail_screen.dart';
import 'package:mama_resto/screens/favorite_screen.dart';
import 'package:mama_resto/screens/settings_screen.dart';
import 'package:mama_resto/screens/splash_screen.dart';
import 'package:mama_resto/sl.dart';

import 'screens/home_screen.dart';
import 'theme_manager/theme_data_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => sl<FavoriteCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<NotificationCubit>(),
          ),
        ],
        child: MaterialApp(
          title: 'Donor Kuy',
          theme: getApplicationThemeData(),
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            DetailScreen.routeName: (context) => DetailScreen(
                  id: ModalRoute.of(context)?.settings.arguments as String,
                ),
            FavoriteScreen.routeName: (context) => const FavoriteScreen(),
            SettingScreen.routeName: (context) => const SettingScreen()
          },
          initialRoute: SplashScreen.routeName,
        ),
      );
}
