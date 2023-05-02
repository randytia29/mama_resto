import 'package:dartz/dartz.dart';
import 'package:mama_resto/features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

import '../models/customer_review.dart';
import '../models/restaurant.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<String, Restaurant>> getDetailRestaurant(String id) async =>
      await remoteDataSource.getDetailRestaurant(id);

  @override
  Future<Either<String, List<Restaurant>>> getListRestaurant(
          String query) async =>
      await remoteDataSource.getListRestaurant(query);

  @override
  Future<Either<String, List<CustomerReview>>> addReview(
          String id, String name, String review) async =>
      await remoteDataSource.addReview(id, name, review);
}
