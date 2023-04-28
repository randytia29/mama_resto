import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_detail_cubit.dart';
import 'package:mama_resto/sl.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';
import 'package:mama_resto/theme_manager/value_manager.dart';

import '../features/restaurant/cubit/favorite_cubit.dart';
import '../theme_manager/color_manager.dart';
import '../widgets/meals_wrap.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = '/detail';

  const DetailScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late RestaurantDetailCubit _restaurantDetailCubit;

  @override
  void initState() {
    super.initState();
    _restaurantDetailCubit = sl<RestaurantDetailCubit>();
  }

  @override
  void dispose() {
    _restaurantDetailCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            _restaurantDetailCubit..fetchRestaurantDetail(widget.id),
        child: BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
          builder: (context, restaurantDetailState) {
            if (restaurantDetailState is RestaurantDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (restaurantDetailState is RestaurantDetailFailed) {
              final message = restaurantDetailState.message;

              return Center(
                child: Text(message),
              );
            }

            if (restaurantDetailState is RestaurantDetailLoaded) {
              final restaurant = restaurantDetailState.restaurant;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag: restaurant.pictureId ?? '-',
                      child: Image.network(
                        ValueManager.largeRes(restaurant.pictureId ?? ''),
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Text(error.toString()),
                        ),
                      ),
                    ),
                    16.0.spaceY,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        8.0.spaceX,
                                        Expanded(
                                          child: Text(
                                            '${restaurant.address}, ${restaurant.city}',
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
                                        8.0.spaceX,
                                        Text(
                                          restaurant.rating.toString(),
                                          style: TextStyle(
                                            color: ColorManager.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              8.0.spaceX,
                              BlocBuilder<FavoriteCubit, FavoriteState>(
                                builder: (context, favoriteState) {
                                  final restaurants = favoriteState.restaurants;

                                  final restaurantDetail = restaurants
                                      .where((element) =>
                                          element.id == restaurant.id)
                                      .toList();

                                  return IconButton(
                                    onPressed: restaurantDetail.isEmpty
                                        ? () {
                                            context
                                                .read<FavoriteCubit>()
                                                .addFavorite(restaurant);
                                          }
                                        : () {
                                            context
                                                .read<FavoriteCubit>()
                                                .deleteFavorite(restaurant);
                                          },
                                    icon: restaurantDetail.isEmpty
                                        ? Icon(
                                            Icons.favorite_border,
                                            color: ColorManager.favorite,
                                          )
                                        : Icon(
                                            Icons.favorite,
                                            color: ColorManager.favorite,
                                          ),
                                  );
                                },
                              )
                            ],
                          ),
                          24.0.spaceY,
                          Text(
                            restaurant.description ?? '-',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          24.0.spaceY,
                          MealsWrap(
                            title: 'Kategori :',
                            categories: restaurant.categories ?? [],
                          ),
                          24.0.spaceY,
                          MealsWrap(
                            title: 'Food :',
                            categories: restaurant.menus!.foods ?? [],
                          ),
                          24.0.spaceY,
                          MealsWrap(
                            title: 'Drink :',
                            categories: restaurant.menus!.drinks ?? [],
                          ),
                          24.0.spaceY,
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.customerReviews?.length,
                              itemBuilder: (context, index) {
                                final review =
                                    restaurant.customerReviews?[index];

                                return Card(
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              review?.name ?? '-',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(review?.date ?? '-')
                                          ],
                                        ),
                                        Text(review?.review ?? '-')
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          24.0.spaceY
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
