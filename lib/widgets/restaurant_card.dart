import 'package:flutter/material.dart';

import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';

import '../theme_manager/color_manager.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              restaurant.pictureId ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
        16.0.spaceX,
        Expanded(
          child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  restaurant.name ?? '-',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: ColorManager.grey,
                    ),
                    Expanded(
                      child: Text(
                        restaurant.city ?? '-',
                        style: TextStyle(
                          color: ColorManager.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorManager.grey,
                    ),
                    Expanded(
                      child: Text(
                        restaurant.rating.toString(),
                        style: TextStyle(
                          color: ColorManager.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
