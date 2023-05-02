import 'package:dartz/dartz.dart';
import 'package:mama_resto/features/restaurant/domain/entities/get_list_restaurant_params.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/restaurant.dart';

class GetListRestaurant
    implements Usecase<List<Restaurant>, GetListRestaurantParams> {
  final RestaurantRepository repository;

  GetListRestaurant(this.repository);

  @override
  Future<Either<String, List<Restaurant>>> call(
          GetListRestaurantParams params) async =>
      await repository.getListRestaurant(params.query);
}
