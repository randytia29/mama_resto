import 'dart:developer';

import 'package:dio/dio.dart';

import '../features/restaurant/domain/entities/restaurant.dart';
import '../theme_manager/value_manager.dart';

class ApiService {
  static Future<List<Restaurant>?> getAllRestaurant() async {
    try {
      final response = await Dio().get('${ValueManager.baseUrl}/list');

      if (response.statusCode != null && response.statusCode == 200) {
        if (!response.data['error']) {
          final restaurants = List.from(response.data['restaurants'])
              .map((e) => Restaurant.fromJson(e))
              .toList();

          return restaurants;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message.toString());
      return null;
    }
  }
}
