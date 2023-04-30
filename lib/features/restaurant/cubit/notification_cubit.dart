import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> with HydratedMixin {
  NotificationCubit() : super(NotificationState.initial());

  void changeEnableNotification(bool enable) =>
      emit(state.copyWith(enable: enable));

  @override
  NotificationState? fromJson(Map<String, dynamic> json) {
    return NotificationState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(NotificationState state) {
    return state.toMap();
  }
}
