part of 'favorite_cubit.dart';

class FavoriteState {
  const FavoriteState({required this.restaurants});

  final List<Restaurant> restaurants;

  factory FavoriteState.initial() {
    return FavoriteState(restaurants: []);
  }

  FavoriteState copyWith({required List<Restaurant> restaurants}) {
    return FavoriteState(restaurants: restaurants);
  }

  Map<String, dynamic>? toMap() {
    final restaurantsToJson = restaurants.map((e) => e.toJson()).toList();

    if (restaurantsToJson.isNotEmpty) {
      return {'data': restaurantsToJson};
    } else {
      return {'data': null};
    }
  }

  factory FavoriteState.fromMap(Map<String, dynamic> json) {
    final response = json['data'];

    final data = List.from(response);

    final restaurants = data.map((e) => Restaurant.fromJson(e)).toList();

    return FavoriteState(restaurants: restaurants);
  }
}
