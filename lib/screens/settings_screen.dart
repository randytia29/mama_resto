import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/utils/background_service.dart';
import 'package:mama_resto/utils/date_time_helper.dart';

import '../features/restaurant/cubit/notification_cubit.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/settings';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocListener<NotificationCubit, NotificationState>(
        listener: (context, notificationState) async {
          final enable = notificationState.enable;

          if (enable) {
            await AndroidAlarmManager.periodic(
                const Duration(days: 1), 1, BackgroundService.callback,
                startAt: DateTimeHelper.format(), exact: true, wakeup: true);
          } else {
            await AndroidAlarmManager.cancel(1);
          }
        },
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, notificationState) {
            final enable = notificationState.enable;
            return SwitchListTile.adaptive(
              value: enable,
              onChanged: (value) => context
                  .read<NotificationCubit>()
                  .changeEnableNotification(value),
              title: const Text('Restaurant Notification'),
              subtitle: const Text('Enable notification'),
            );
          },
        ),
      ),
    );
  }
}
