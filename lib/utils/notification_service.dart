import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:rxdart/rxdart.dart';

import 'navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> notificationInitialize(
      void Function(NotificationResponse)?
          onDidReceiveBackgroundNotificationResponse) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('logo_launcher');

    const initializationSettingsIOS = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        final payload = notificationResponse.payload;

        if (payload != null) {
          log('notification payload: $payload');
        }

        selectNotificationSubject.add(payload ?? 'empty payload');
      },
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  static Future<void> showNotification(int id, Restaurant restaurant) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channelDescription',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(0, restaurant.name,
        'Recommendation restaurant for you', platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  static Future<void> requestPermission() async {
    final androidImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestPermission();
  }

  static void configureSelectNotificationSubject(String route) =>
      selectNotificationSubject.stream.listen(
        (String payload) async {
          var data = Restaurant.fromJson(json.decode(payload));
          Navigation.intentWithData(route, data);
        },
      );
}
