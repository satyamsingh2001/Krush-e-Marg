import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';
import '../views/bottom_nav_bar/bottom_nav_bar.dart';

class NotificationServices {
  FirebaseMessaging massaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await massaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted provision permission');
      }
    } else {
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  void initNotification( RemoteMessage message) async {
    var androidInitializationSettings =
    const AndroidInitializationSettings('@drawable/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(  message);
        });
  }

  void FirebaseInit( ) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data.toString());
        print(message.data['chat']);
        print(message.data['id']);
      }
      initNotification( message  );
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(),
        'High Importance Notification',
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString(),
        channelDescription: 'This is channel description',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');
    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<String?> getDeviceToken() async {
    massaging.getToken();
    return await massaging.getToken();
  }

  void isTokenReferesh() async {
    massaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('token refresh');
      }
    });
  }

  Future<void> setupInteractMessage(  )async {
    RemoteMessage? initialMessage= await FirebaseMessaging.instance.getInitialMessage();
//when app is terminated
    if(initialMessage!=null){
      handleMessage(  initialMessage);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        handleMessage(  event);
      });
    }
    //when app is in background
  }

  void handleMessage(  RemoteMessage message) {
    if (message.data['chat'] == 'msg') {
      Navigator.pushAndRemoveUntil(
          MyApp.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const DashBoardScreenMain(currentIndex: 0,)),
              (route) => false);
    }
  }
}
