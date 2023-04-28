import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/search_restaurant_cubit.dart';
import 'package:mama_resto/sl.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';
import 'package:mama_resto/widgets/restaurant_card.dart';

import '../theme_manager/color_manager.dart';
import '../widgets/header_home.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  late SearchRestaurantCubit _searchRestaurantCubit;
  late RestaurantCubit _restaurantCubit;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchRestaurantCubit = sl<SearchRestaurantCubit>();
    _restaurantCubit = sl<RestaurantCubit>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchRestaurantCubit.close();
    _restaurantCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _searchRestaurantCubit,
          ),
          BlocProvider(
            create: (context) => _restaurantCubit..fetchRestaurant(),
          ),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const HeaderHome(),
                24.0.spaceY,
                Expanded(
                  child: BlocBuilder<RestaurantCubit, RestaurantState>(
                    builder: (context, restaurantState) {
                      if (restaurantState is RestaurantLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (restaurantState is RestaurantFailed) {
                        final message = restaurantState.message;

                        return Center(
                          child: Text(message),
                        );
                      }

                      if (restaurantState is RestaurantLoaded) {
                        final restaurants = restaurantState.restaurants;

                        _searchRestaurantCubit.getRestaurantInit(restaurants);

                        return Column(
                          children: [
                            TextFormField(
                              controller: _searchController,
                              onChanged: (value) => _searchRestaurantCubit
                                  .startSearchRestaurant(restaurants, value),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(color: ColorManager.grey),
                                fillColor: ColorManager.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorManager.grey),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            16.0.spaceY,
                            BlocBuilder<SearchRestaurantCubit,
                                SearchRestaurantState>(
                              builder: (context, searchRestaurantState) {
                                final restos =
                                    searchRestaurantState.restaurants;

                                return Expanded(
                                  child: ListView.separated(
                                    itemCount: restos.length,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final resto = restos[index];

                                      return RestaurantCard(restaurant: resto);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return 16.0.spaceY;
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
