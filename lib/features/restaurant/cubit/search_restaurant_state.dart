part of 'search_restaurant_cubit.dart';

class SearchRestaurantState extends Equatable {
  const SearchRestaurantState(
      {required this.restaurants, required this.keyword});

  final List<Restaurant> restaurants;
  final String keyword;

  factory SearchRestaurantState.initial() {
    return const SearchRestaurantState(
      restaurants: <Restaurant>[],
      keyword: '',
    );
  }

  SearchRestaurantState restaurantCopyWith(
      {required List<Restaurant> restaurants}) {
    return SearchRestaurantState(restaurants: restaurants, keyword: keyword);
  }

  SearchRestaurantState keywordCopyWith(
      {required List<Restaurant> restaurants, required String keyword}) {
    return SearchRestaurantState(restaurants: restaurants, keyword: keyword);
  }

  @override
  List<Object> get props => [restaurants, keyword];
}
