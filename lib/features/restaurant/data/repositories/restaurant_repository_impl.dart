import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mama_resto/features/restaurant/domain/entities/customer_review.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:dartz/dartz.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:mama_resto/theme_manager/value_manager.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final Dio dio;

  RestaurantRepositoryImpl({required this.dio});

  @override
  Future<Either<String, Restaurant>> getDetailRestaurant(String id) async {
    try {
      final response = await dio.get('${ValueManager.baseUrl}/detail/$id');

      if (response.statusCode != null && response.statusCode == 200) {
        if (!response.data['error']) {
          final restaurant = Restaurant.fromJson(response.data['restaurant']);

          return Right(restaurant);
        } else {
          return Left(response.data['message']);
        }
      } else {
        return Left(response.statusMessage ?? '-');
      }
    } on DioError catch (e) {
      log(e.message.toString());
      return Left(e.message ?? ValueManager.noInternet);
    }
  }

  @override
  Future<Either<String, List<Restaurant>>> getListRestaurant(
      String query) async {
    try {
      final response = await dio
          .get('${ValueManager.baseUrl}/search', queryParameters: {'q': query});

      if (response.statusCode != null && response.statusCode == 200) {
        if (!response.data['error']) {
          final restaurants = List.from(response.data['restaurants'])
              .map((e) => Restaurant.fromJson(e))
              .toList();

          return Right(restaurants);
        } else {
          return Left(response.statusMessage ?? '-');
        }
      } else {
        return Left(response.statusMessage ?? '-');
      }
    } on DioError catch (e) {
      log(e.message.toString());
      return Left(e.message ?? ValueManager.noInternet);
    }
  }

  @override
  Future<Either<String, List<CustomerReview>>> addReview(
      String id, String name, String review) async {
    try {
      final response = await dio.post('${ValueManager.baseUrl}/review',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: {'id': id, 'name': name, 'review': review});

      if (response.statusCode != null) {
        if (!response.data['error']) {
          final reviews = List.from(response.data['customerReviews'])
              .map((e) => CustomerReview.fromJson(e))
              .toList();

          return Right(reviews);
        } else {
          return Left(response.statusMessage ?? '-');
        }
      } else {
        return Left(response.statusMessage ?? '-');
      }
    } on DioError catch (e) {
      log(e.message.toString());
      return Left(e.message ?? ValueManager.noInternet);
    }
  }
}
