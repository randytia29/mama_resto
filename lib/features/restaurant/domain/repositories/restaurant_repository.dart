import 'package:dartz/dartz.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<Either<String, List<Restaurant>>> getListRestaurant();
}
