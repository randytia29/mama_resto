import 'package:dartz/dartz.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<Either<String, List<Restaurant>>> getListRestaurant(String query);
  Future<Either<String, Restaurant>> getDetailRestaurant(String id);
}
