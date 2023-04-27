import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/features/restaurant/cubit/favorite_cubit.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:mama_resto/screens/detail_screen.dart';
import 'package:mama_resto/screens/favorite_screen.dart';
import 'package:mama_resto/screens/splash_screen.dart';
import 'package:mama_resto/sl.dart';

import 'screens/home_screen.dart';
import 'theme_manager/theme_data_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (BuildContext context) => sl<FavoriteCubit>(),
        child: MaterialApp(
          title: 'Donor Kuy',
          theme: getApplicationThemeData(),
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            DetailScreen.routeName: (context) => DetailScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
            FavoriteScreen.routeName: (context) => const FavoriteScreen()
          },
          initialRoute: SplashScreen.routeName,
        ),
      );
}
