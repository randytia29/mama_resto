import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../data/models/restaurant.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> with HydratedMixin {
  FavoriteCubit() : super(FavoriteState.initial());

  void addFavorite(Restaurant restaurant) {
    var restaurants = state.restaurants;

    restaurants.add(restaurant);

    emit(state.copyWith(restaurants: restaurants));
  }

  void deleteFavorite(Restaurant restaurant) {
    var restaurants = state.restaurants;

    restaurants.remove(restaurant);

    emit(state.copyWith(restaurants: restaurants));
  }

  @override
  FavoriteState? fromJson(Map<String, dynamic> json) {
    return FavoriteState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoriteState state) {
    return state.toMap();
  }
}
