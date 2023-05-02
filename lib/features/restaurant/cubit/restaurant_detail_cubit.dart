import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/features/restaurant/domain/entities/get_detail_restaurant_params.dart';
import 'package:mama_resto/features/restaurant/domain/usecases/get_detail_restaurant.dart';

import '../data/models/restaurant.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  final GetDetailRestaurant getDetailRestaurant;

  RestaurantDetailCubit({required GetDetailRestaurant detailRestaurant})
      : getDetailRestaurant = detailRestaurant,
        super(RestaurantDetailInitial());

  void fetchRestaurantDetail(String id) async {
    emit(RestaurantDetailLoading());

    final result = await getDetailRestaurant(GetDetailRestaurantParams(id: id));

    result.fold((l) => emit(RestaurantDetailFailed(message: l)),
        (r) => emit(RestaurantDetailLoaded(restaurant: r)));
  }
}
