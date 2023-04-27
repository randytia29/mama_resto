import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/theme_manager/navigation_manager.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';

import '../features/restaurant/cubit/favorite_cubit.dart';
import '../screens/favorite_screen.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
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
        ),
        8.0.spaceX,
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, favoriteState) {
            final restaurants = favoriteState.restaurants;

            return IconButton(
              onPressed: () => context.toScreen(FavoriteScreen.routeName),
              icon: Badge(
                isLabelVisible: restaurants.isNotEmpty,
                child: const Icon(Icons.favorite_border),
              ),
            );
          },
        )
      ],
    );
  }
}