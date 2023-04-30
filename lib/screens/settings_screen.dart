import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, notificationState) {
          final enable = notificationState.enable;
          return SwitchListTile.adaptive(
            value: enable,
            onChanged: (value) {
              context
                  .read<NotificationCubit>()
                  .changeEnableNotification(value, 1);
            },
            title: const Text('Restaurant Notification'),
            subtitle: const Text('Enable notification'),
          );
        },
      ),
    );
  }
}
