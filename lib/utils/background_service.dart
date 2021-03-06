import 'dart:math';
import 'dart:ui';
import 'dart:isolate';

import 'package:restaurant_app/data/services/restaurant_api.dart';
import 'package:restaurant_app/main.dart';

import '../data/models/restaurant.dart';
import '../helper/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    var resultRaw = await RestaurantApi().getRestaurantList();
    List<Restaurant> result =
        resultRaw.map((item) => Restaurant.fromJson(item)).toList();

    Random random = Random();
    var randomNumber = random.nextInt(result.length);

    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result[randomNumber],
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}