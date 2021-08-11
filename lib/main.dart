
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mylamsy/screen/appbar/notification_service.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/translations/codegen_loader.g.dart';

import 'controller/auth_Api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/screen/all_auth_screens/splash_screen.dart';
import 'package:mylamsy/screen/appbar/notification_screen.dart';
import 'package:mylamsy/screen/home_tabs/home_screen.dart';
import 'package:mylamsy/shared/commponent.dart';
import 'package:shared_preferences/shared_preferences.dart';
//final ReceivePort port = ReceivePort();
//const String isolateName = 'isolate';
//BuildContext context;
SharedPreferences preferences;
 savefirebasetoken(String firebasetoken) async{

  preferences = await SharedPreferences.getInstance();
  preferences.setString('token', firebasetoken);
  print("toooo"+preferences.getString('token'));
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  enableVibration: true,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  //await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp()
  ),);

FirebaseMessaging fcm = FirebaseMessaging.instance;
fcm.getToken().then((value) {
  savefirebasetoken(value);
  Authentication auth=Authentication();
  auth.upgradeTokenUser(value);
  print(value);
});

fcm.subscribeToTopic('clients').then((value) => print("yeeeeeeeeeeeeeeeeeeees"));
  //initMessaging();
}

/*void initMessaging() {
  FlutterLocalNotificationsPlugin fltNotification;
  var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInit = IOSInitializationSettings();
  var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
  fltNotification = FlutterLocalNotificationsPlugin();
  fltNotification.initialize(initSetting);
  var androidDetails =
  AndroidNotificationDetails('1', 'channelName', 'channel Description');
  var iosDetails = IOSNotificationDetails();
  var generalNotificationDetails =
  NotificationDetails(android: androidDetails, iOS: iosDetails);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification=message.notification;
    AndroidNotification android=message.notification?.android;
    if(notification!=null && android!=null){
      fltNotification.show(
          notification.hashCode, notification.title, notification.body, generalNotificationDetails);
    }});
 }*/


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // context = context;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: "MyLamesy",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}