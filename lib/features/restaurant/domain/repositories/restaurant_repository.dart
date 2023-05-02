import 'package:dartz/dartz.dart';

import '../../data/models/customer_review.dart';
import '../../data/models/restaurant.dart';

abstract class RestaurantRepository {
  Future<Either<String, List<Restaurant>>> getListRestaurant(String query);
  Future<Either<String, Restaurant>> getDetailRestaurant(String id);
  Future<Either<String, List<CustomerReview>>> addReview(
      String id, String name, String review);
}
