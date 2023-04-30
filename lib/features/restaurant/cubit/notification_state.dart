part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({required this.enable});

  final bool enable;

  factory NotificationState.initial() {
    return const NotificationState(enable: false);
  }

  NotificationState copyWith({required bool enable}) {
    return NotificationState(enable: enable);
  }

  Map<String, dynamic>? toMap() => {'enable': enable};

  factory NotificationState.fromMap(Map<String, dynamic> json) =>
      NotificationState(enable: json['enable']);

  @override
  List<Object> get props => [enable];
}
