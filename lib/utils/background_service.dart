import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:mama_resto/utils/api_service.dart';
import 'package:mama_resto/utils/notification_service.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static const String _isolateName = 'isolate';

  static SendPort? _uiSendPort;

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm fired!');

    final restaurants = await ApiService.getAllRestaurant();

    if (restaurants != null) {
      final randomIndex = Random().nextInt(restaurants.length);
      final restaurant = restaurants[randomIndex];

      await NotificationService.showNotification(1, restaurant);
    }

    _uiSendPort ?? IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async =>
      print('Updated data from the background isolate');
}
