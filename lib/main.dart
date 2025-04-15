import 'dart:convert';
import 'dart:developer';

import 'package:aerodiary/Utlis/firebaseAPI.dart';
import 'package:aerodiary/Utlis/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:upgrader/upgrader.dart';

final navigatorKey = GlobalKey<NavigatorState>();

//function to listen background changes

GetStorage box = GetStorage();
// Future _firebaseBackgroundMessage(RemoteMessage message) async {
//   //log("got notification background");
// }

Future<void> main() async {
  Intl.defaultLocale == "de_DE";
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Upgrader.clearSavedSettings();
  // await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //on background notification tapped
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   if (message.notification != null) {
  //     //log("Background Notification Tapped");
  //     if (box.read("login") == null) {
  //       Get.offAllNamed('/');
  //     } else {
  //       Get.toNamed("/notification", arguments: message);
  //       //navigatorKey.currentState!.pushNamed("/notification", arguments: message);
  //     }
  //   }
  // });

  // PushNotification().init();
  // PushNotification.local();

  //listen to backgorund notification
  // FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  //countCubit = BlocProvider.of<CountCubit>(context);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //   //map payload data
  //   String payloadData = jsonEncode(message.data);

  //   if (message.notification != null) {
  //     PushNotification.showSimpleNotification(
  //         title: message.notification!.title ?? "Demo Notification",
  //         body: message.notification!.body ?? "Notification from AeroDiary",
  //         payload: payloadData);
  //   }
  // });
  // debugRepaintRainbowEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: ScreenUtilInit(
        // designSize: Size(360, 690),
        designSize: const Size(390, 844),
        // for web app
        useInheritedMediaQuery: true,
        //for keyboard not overlap
        // //designSize: const Size(1080, 1920), //for android application
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, state) {
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            // initialRoute:
            //     //'/onSitePunch',
            //     box.read("authtoken") == null ? '/' : '/dashBoard',
            initialRoute: '/splash_screen',
            getPages: Routes.pages,

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}
