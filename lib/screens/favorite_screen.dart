import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';

import '../features/restaurant/cubit/favorite_cubit.dart';
import '../widgets/restaurant_card.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = '/favorite';

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, favoriteState) {
            final restaurants = favoriteState.restaurants;

            if (restaurants.isEmpty) {
              return const Center(
                child: Text('Tidak ada restoran favorit'),
              );
            }

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
      ),
    );
  }
}
