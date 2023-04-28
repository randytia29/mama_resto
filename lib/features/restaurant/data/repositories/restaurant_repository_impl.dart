import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:dartz/dartz.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:mama_resto/theme_manager/value_manager.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final Dio dio;

  RestaurantRepositoryImpl({required this.dio});

  @override
  Future<Either<String, List<Restaurant>>> getListRestaurant() async {
    try {
      final response = await dio.get('${ValueManager.baseUrl}/list');

      if (response.statusCode != null && response.statusCode == 200) {
        if (!response.data['error']) {
          final restaurants = List.from(response.data['restaurants'])
              .map((e) => Restaurant.fromJson(e))
              .toList();

          return Right(restaurants);
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
}