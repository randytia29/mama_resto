import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> with HydratedMixin {
  NotificationCubit() : super(NotificationState.initial());

  void changeEnableNotification(bool enable) async =>
      emit(state.copyWith(enable: enable));

  @override
  NotificationState? fromJson(Map<String, dynamic> json) =>
      NotificationState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(NotificationState state) => state.toMap();
}
