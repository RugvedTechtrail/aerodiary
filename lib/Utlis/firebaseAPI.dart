import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:aerodiary/Utlis/api.dart';

import 'package:aerodiary/main.dart';

class PushNotification {
  GetStorage box = GetStorage();
  API api = API();

  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  //request notification permission
  Future init() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    void requestPermission() async {
      await _flutterLocalNotificationPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

//get device fcm token
    final token =
        //Platform.isAndroid?
        await _firebaseMessaging.getToken();
    //:await _firebaseMessaging.getAPNSToken();

    await box.write("fcmtoken", token);
    if (box.read("bioId") != null) {
      //log("called when fcm is null");
      //  homeRepo.getUpdateFcm(box.read("bioId").toString(), box.read("fcmtoken"));
    }

    //log("FCM-TOKEN is $token");
  }

//intialize local notification
  static Future local() async {
    //log("intialize");
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDrawn =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestCriticalPermission: true,
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDrawn,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  //on tap local notification in foreground
  static void onNotificationTap(NotificationResponse notificationResponse) {
    //log("notificATION tapped");
    navigatorKey.currentState!
        .pushNamed("/notification", arguments: notificationResponse);
  }

  //show simple notification
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    //log("notification arrived");
    int notificationId = DateTime.now().millisecondsSinceEpoch % 2147483647;
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "pushnotificationapp",
      "pushnotificationappchannel",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@drawable/ic_launcher',
    );

    //IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            presentBanner: true);

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _flutterLocalNotificationPlugin.show(
        notificationId, title, body, notificationDetails,
        payload: payload);
  }

  static Future setCount({
    required int count,
  }) async {
    await GetStorage().write('notiCount', count);
  }
}
