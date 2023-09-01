import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/services/notification_services.dart';
import 'app/splash/splash_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try{
    await Firebase.initializeApp();
    if (kDebugMode) {
      print("${message.notification?.title.toString()} amar");
    }
  }catch(e){
    if (kDebugMode) {
      print("$e");
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher',
      [
        NotificationChannel(
            channelGroupKey: 'category_tests',
            channelKey: 'call_channel',
            channelName: 'Calls Channel',
            channelDescription: 'Channel with call ringtone',
            importance: NotificationImportance.Max,
            ledColor: Colors.white,
            channelShowBadge: true,
            locked: true,
            defaultRingtoneType: DefaultRingtoneType.Alarm
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupName: 'category_tests', channelGroupKey: 'category_tests',
        )
      ],
      debug: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
  FirebaseMessaging.instance.subscribeToTopic("topic");
  NotificationServices notificationServices = NotificationServices();
  notificationServices.requestNotificationPermission();
  notificationServices.FirebaseInit( );
  notificationServices.setupInteractMessage( );
  notificationServices.getDeviceToken().then((value) {
    if (kDebugMode) {
      print('Device token- $value');
    }

  });


  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString("userId");
  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  final String? userId;
  const MyApp({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}