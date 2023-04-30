import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mama_resto/utils/background_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'app.dart';
import 'sl.dart' as sl;
import 'utils/notification_service.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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

Future<void> notificationInitialize() async {
  const initializationSettingsAndroid =
      AndroidInitializationSettings('logo_launcher');

  const initializationSettingsIOS = DarwinInitializationSettings();

  const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (notificationResponse) {
      final payload = notificationResponse.payload;

      if (payload != null) {
        log('notification payload: $payload');
      }

      selectNotificationSubject.add(payload ?? 'empty payload');
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: appDocumentDirectory);

  await notificationInitialize();
  tz.initializeTimeZones();

  final BackgroundService service = BackgroundService();

  service.initializeIsolate();
  await AndroidAlarmManager.initialize();

  await sl.init(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}
