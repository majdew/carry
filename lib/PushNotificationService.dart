import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initilize() async {
    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission();

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // App  Icon for notification
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
  }

  static getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    print(token);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              _channel.description,
            ),
          ));
    }
  }

  static Future<void> _firebaseMessagingForegroundHandler(
      RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              _channel.description,
            ),
          ));
    }
  }

  String constructFCMPayload(String toToken) {
    return jsonEncode({
      "to":
          "e4bfVdnaQgSHFX9Mt63NWz:APA91bEQRBA2_zjk0mPHaF_J34EBlaCbYvEtU_lnuExQTlJN5UVgxPLdqNl2znUvbB524KfoivJvw-m34NA1xuQQU0sfBa0ml9m9BWYmywzWlirj0mLWX_8TNBqH4D0mOJsSP9QcNxrx",
      "data": {
        "via": "FlutterFire Cloud Messaging!!!",
        "count": "This is message"
      },
      "notification": {
        "title": "Hello FlutterFire!",
        "body": "This notification was created via FCM!"
      }
    });
  }

  Future<void> sendPushMessage(String toToken) async {
    String serverKey =
        'AAAAfCHL8lY:APA91bHkjfIghP9pbElAFtuRE39N1aJnZT13_OPzzBRlyx2VMYDB7Zg9Lk7zH7GCPhyJ40Mvqv1hSRnXGEZziiSAeIAN0cOd2th2cDIHEB1MoMCNwQxndtO31A1ORHF_AhdR0P9GTqAT';

    try {
      print('key=$serverKey');

      var result = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String,String> {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "key=$serverKey"
        },
        body: constructFCMPayload(toToken),
      );
      print(result.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
