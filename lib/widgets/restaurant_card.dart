import 'package:flutter/material.dart';

import 'package:mama_resto/screens/detail_screen.dart';
import 'package:mama_resto/theme_manager/navigation_manager.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';
import 'package:mama_resto/theme_manager/value_manager.dart';

import '../features/restaurant/data/models/restaurant.dart';
import '../theme_manager/color_manager.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.toScreen(DetailScreen.routeName, arguments: restaurant.id),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: restaurant.pictureId ?? '-',
                    child: Image.network(
                      ValueManager.smallRes(restaurant.pictureId ?? ''),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                    ),
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
          ),
        ),
      ),
    );
  }
}
