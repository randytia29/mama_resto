import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mama_resto/utils/background_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'app.dart';
import 'sl.dart' as sl;
import 'utils/notification_service.dart';

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

void notificationTapBackground(NotificationResponse notificationResponse) {
  log('test background');
  log('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    log('notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: appDocumentDirectory);

  await NotificationService.notificationInitialize(notificationTapBackground);

  final BackgroundService service = BackgroundService();

  service.initializeIsolate();
  await AndroidAlarmManager.initialize();

  await sl.init();

  runApp(const MyApp());
}
