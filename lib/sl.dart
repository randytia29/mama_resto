import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mama_resto/features/restaurant/cubit/add_review_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/favorite_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/notification_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_detail_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/review_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/search_restaurant_cubit.dart';
import 'package:mama_resto/features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'package:mama_resto/features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:mama_resto/features/restaurant/domain/usecases/add_review.dart';
import 'package:mama_resto/features/restaurant/domain/usecases/get_detail_restaurant.dart';
import 'package:mama_resto/features/restaurant/domain/usecases/get_list_restaurant.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc

  // Restaurant
  sl.registerLazySingleton(() => FavoriteCubit());
  sl.registerFactory(() => SearchRestaurantCubit());
  sl.registerFactory(() => RestaurantCubit(listRestaurant: sl()));
  sl.registerFactory(() => RestaurantDetailCubit(detailRestaurant: sl()));
  sl.registerFactory(() => AddReviewCubit(review: sl()));
  sl.registerFactory(() => ReviewCubit());
  sl.registerLazySingleton(() => NotificationCubit());

  // Use cases
  sl.registerLazySingleton(() => GetDetailRestaurant(sl()));
  sl.registerLazySingleton(() => GetListRestaurant(sl()));
  sl.registerLazySingleton(() => AddReview(sl()));

  // Repository
  sl.registerLazySingleton<RestaurantRepository>(
      () => RestaurantRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(dio: sl()));

  //! External
  sl.registerLazySingleton(() => Dio());
}
