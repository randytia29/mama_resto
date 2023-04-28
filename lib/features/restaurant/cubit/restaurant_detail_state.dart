part of 'restaurant_detail_cubit.dart';

abstract class RestaurantDetailState extends Equatable {
  const RestaurantDetailState();

  @override
  List<Object> get props => [];
}

class RestaurantDetailInitial extends RestaurantDetailState {}

class RestaurantDetailLoading extends RestaurantDetailState {}

class RestaurantDetailLoaded extends RestaurantDetailState {
  final Restaurant restaurant;

  const RestaurantDetailLoaded({required this.restaurant});

  @override
  List<Object> get props => [restaurant];
}

class RestaurantDetailFailed extends RestaurantDetailState {
  final String message;

  const RestaurantDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}
