import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/restaurant.dart';
import '../domain/repositories/restaurant_repository.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  final RestaurantRepository repository;

  RestaurantDetailCubit({
    required RestaurantRepository restaurantRepository,
  })  : repository = restaurantRepository,
        super(RestaurantDetailInitial());

  void fetchRestaurantDetail(String id) async {
    emit(RestaurantDetailLoading());

    final result = await repository.getDetailRestaurant(id);

    result.fold((l) => emit(RestaurantDetailFailed(message: l)),
        (r) => emit(RestaurantDetailLoaded(restaurant: r)));
  }
}
