import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/features/restaurant/cubit/search_restaurant_cubit.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:mama_resto/sl.dart';
import 'package:mama_resto/theme_manager/asset_manager.dart';
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

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchRestaurantCubit = sl<SearchRestaurantCubit>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchRestaurantCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _searchRestaurantCubit,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HeaderHome(),
                  24.0.spaceY,
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          24.0.spaceY,
                          BlocBuilder<SearchRestaurantCubit,
                              SearchRestaurantState>(
                            builder: (context, searchRestaurantState) {
                              final restos = searchRestaurantState.restaurants;

                              return ListView.separated(
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
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
