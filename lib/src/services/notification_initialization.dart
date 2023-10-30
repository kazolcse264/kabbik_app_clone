 import 'package:flutter_local_notifications/flutter_local_notifications.dart';
 notificationInitialized() async {
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
   FlutterLocalNotificationsPlugin();

   const AndroidInitializationSettings initializationSettingsAndroid =
   AndroidInitializationSettings('@mipmap/ic_launcher');
   DarwinInitializationSettings initializationSettingsDarwin =
   const DarwinInitializationSettings(
     onDidReceiveLocalNotification: onDidReceiveLocalNotification,
   );
   const LinuxInitializationSettings initializationSettingsLinux =
   LinuxInitializationSettings(defaultActionName: 'Open notification');
   InitializationSettings initializationSettings = InitializationSettings(
     android: initializationSettingsAndroid,
     iOS: initializationSettingsDarwin,
     macOS: initializationSettingsDarwin,
     linux: initializationSettingsLinux,
   );

   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
 }

 void onDidReceiveLocalNotification(
     int id, String? title, String? body, String? payload) {
   // Handle the received local notification
 }