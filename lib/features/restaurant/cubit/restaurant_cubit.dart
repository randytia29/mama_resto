import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/features/restaurant/domain/entities/get_list_restaurant_params.dart';
import 'package:mama_resto/features/restaurant/domain/usecases/get_list_restaurant.dart';

import '../data/models/restaurant.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GetListRestaurant getListRestaurant;

  RestaurantCubit({
    required GetListRestaurant listRestaurant,
  })  : getListRestaurant = listRestaurant,
        super(RestaurantInitial());

  void fetchRestaurant({String? query}) async {
    emit(RestaurantLoading());

    final result =
        await getListRestaurant(GetListRestaurantParams(query: query ?? ''));

    result.fold((l) => emit(RestaurantFailed(message: l)),
        (r) => emit(RestaurantLoaded(restaurants: r)));
  }
}
