part of 'restaurant_cubit.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  const RestaurantLoaded({required this.restaurants});

  @override
  List<Object> get props => [restaurants];
}

class RestaurantFailed extends RestaurantState {
  final String message;

  const RestaurantFailed({required this.message});

  @override
  List<Object> get props => [message];
}
