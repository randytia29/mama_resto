import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepository repository;

  RestaurantCubit({
    required RestaurantRepository restaurantRepository,
  })  : repository = restaurantRepository,
        super(RestaurantInitial());

  void fetchRestaurant({String? query}) async {
    emit(RestaurantLoading());

    final result = await repository.getListRestaurant(query ?? '');

    result.fold((l) => emit(RestaurantFailed(message: l)),
        (r) => emit(RestaurantLoaded(restaurants: r)));
  }
}
