import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/restaurant.dart';

part 'search_restaurant_state.dart';

class SearchRestaurantCubit extends Cubit<SearchRestaurantState> {
  SearchRestaurantCubit() : super(SearchRestaurantState.initial());

  void getRestaurantInit(List<Restaurant> restaurants) {
    var keyword = state.keyword;

    if (keyword.isNotEmpty) {
      var restaurant = restaurants
          .where((element) =>
              element.name!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();

      emit(state.restaurantCopyWith(restaurants: restaurant));
    } else {
      emit(state.restaurantCopyWith(restaurants: restaurants));
    }
  }

  void startSearchRestaurant(List<Restaurant> restaurants, String keyword) {
    var restaurant = restaurants
        .where((element) =>
            element.name!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    emit(state.keywordCopyWith(restaurants: restaurant, keyword: keyword));
  }
}
