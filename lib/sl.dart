import 'package:get_it/get_it.dart';
import 'package:mama_resto/features/restaurant/cubit/favorite_cubit.dart';
import 'package:mama_resto/features/restaurant/cubit/search_restaurant_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc

  // Restaurant
  sl.registerLazySingleton(() => FavoriteCubit());
  sl.registerFactory(() => SearchRestaurantCubit());
}
