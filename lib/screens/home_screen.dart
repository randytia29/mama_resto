import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_cubit.dart';
import 'package:mama_resto/sl.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';
import 'package:mama_resto/widgets/restaurant_card.dart';

import '../widgets/custom_text_form.dart';
import '../widgets/header_home.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  late RestaurantCubit _restaurantCubit;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _restaurantCubit = sl<RestaurantCubit>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _restaurantCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
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
                CustomTextForm(
                  searchController: _searchController,
                  hint: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () => _restaurantCubit.fetchRestaurant(
                        query: _searchController.text),
                    icon: const Icon(Icons.search),
                  ),
                ),
                16.0.spaceY,
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

                        if (restaurants.isEmpty) {
                          return const Center(
                            child: Text('Tidak ada data'),
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
                          separatorBuilder: (BuildContext context, int index) =>
                              16.0.spaceY,
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
