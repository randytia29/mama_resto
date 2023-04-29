import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mama_resto/features/restaurant/cubit/add_review_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/favorite_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_detail_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/review_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/search_restaurant_cubit.dart';
import 'package:mama_resto/features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc

  // Restaurant
  sl.registerLazySingleton(() => FavoriteCubit());
  sl.registerFactory(() => SearchRestaurantCubit());
  sl.registerFactory(() => RestaurantCubit(restaurantRepository: sl()));
  sl.registerFactory(() => RestaurantDetailCubit(restaurantRepository: sl()));
  sl.registerFactory(() => AddReviewCubit(restaurantRepository: sl()));
  sl.registerFactory(() => ReviewCubit());

  // Repository
  sl.registerLazySingleton<RestaurantRepository>(
      () => RestaurantRepositoryImpl(dio: sl()));

  //! External
  sl.registerLazySingleton(() => Dio());
}
