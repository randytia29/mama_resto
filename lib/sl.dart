import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/shared_pref.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Shared Preference
  final sharedPreferences = await SharedPreferences.getInstance();

  //! Features
  // Bloc

  // Repository
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dio: sl()));

  //! External
  sl.registerLazySingleton(
      () => SharedPref(sharedPreferences: sharedPreferences));
}
