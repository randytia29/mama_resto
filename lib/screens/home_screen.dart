import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:mama_resto/screens/favorite_screen.dart';
import 'package:mama_resto/theme_manager/asset_manager.dart';
import 'package:mama_resto/theme_manager/navigation_manager.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';
import 'package:mama_resto/widgets/restaurant_card.dart';

import '../features/restaurant/cubit/favorite_cubit.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'MaMa Resto',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Choose your Resto for your hunger',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    8.0.spaceX,
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, favoriteState) {
                        final restaurants = favoriteState.restaurants;

                        return IconButton(
                          onPressed: () =>
                              context.toScreen(FavoriteScreen.routeName),
                          icon: Badge(
                            isLabelVisible: restaurants.isNotEmpty,
                            child: const Icon(Icons.favorite_border),
                          ),
                        );
                      },
                    )
                  ],
                ),
                32.0.spaceY,
                FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString(AssetManager.localRestaurantJson),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    final data = snapshot.data;

                    if (data == null) {
                      return Text(snapshot.error.toString());
                    }

                    final jsonData = jsonDecode(data);

                    final restaurants = List.from(jsonData['restaurants'])
                        .map((e) => Restaurant.fromJson(e))
                        .toList();

                    return ListView.separated(
                      itemCount: restaurants.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];

                        return RestaurantCard(restaurant: restaurant);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return 16.0.spaceY;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
