import 'package:flutter/material.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';

import '../theme_manager/color_manager.dart';

class DetailScreen extends StatelessWidget {
  static const String routeName = '/detail';

  const DetailScreen({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: restaurant.pictureId ?? '',
              child: Image.network(restaurant.pictureId ?? '-'),
            ),
            16.0.spaceY,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    restaurant.name ?? '-',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.0.spaceY,
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
                  8.0.spaceY,
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
                  ),
                  24.0.spaceY,
                  Text(
                    restaurant.description ?? '-',
                  ),
                  24.0.spaceY,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Food :',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            ...restaurant.menu!.foods!
                                .map(
                                  (e) => Text(
                                    '- ${e.name}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                                .toList()
                          ],
                        ),
                      ),
                      8.0.spaceX,
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Drink :',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            ...restaurant.menu!.drinks!
                                .map(
                                  (e) => Text(
                                    '- ${e.name}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                                .toList()
                          ],
                        ),
                      ),
                    ],
                  ),
                  24.0.spaceY
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
