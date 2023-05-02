import 'package:dartz/dartz.dart';
import 'package:mama_resto/core/usecases/usecase.dart';
import 'package:mama_resto/features/restaurant/domain/entities/get_detail_restaurant_params.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

import '../../data/models/restaurant.dart';

class GetDetailRestaurant
    implements Usecase<Restaurant, GetDetailRestaurantParams> {
  final RestaurantRepository repository;

  GetDetailRestaurant(this.repository);

  @override
  Future<Either<String, Restaurant>> call(
          GetDetailRestaurantParams params) async =>
      await repository.getDetailRestaurant(params.id);
}
