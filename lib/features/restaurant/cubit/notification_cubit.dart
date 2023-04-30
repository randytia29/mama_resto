import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mama_resto/utils/notification_service.dart';

import '../domain/repositories/restaurant_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> with HydratedMixin {
  final NotificationService service;
  final RestaurantRepository repository;

  NotificationCubit({
    required NotificationService notificationService,
    required RestaurantRepository restaurantRepository,
  })  : service = notificationService,
        repository = restaurantRepository,
        super(NotificationState.initial());

  void changeEnableNotification(bool enable, int id) async {
    if (enable) {
      final result = await repository.getListRestaurant('');

      result.fold((l) => null, (r) {
        final randomIndex = Random().nextInt(r.length);
        final restaurant = r[randomIndex];

        service.scheduleNotification(
            id, restaurant.name, 'Recommendation restaurant for you');
      });
    } else {
      await service.cancelNotification(id);
    }

    emit(state.copyWith(enable: enable));
  }

  @override
  NotificationState? fromJson(Map<String, dynamic> json) =>
      NotificationState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(NotificationState state) => state.toMap();
}
