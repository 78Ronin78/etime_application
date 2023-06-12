// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:etime_application/models/notification_model.dart';
import 'package:etime_application/repository/save_values_to_local_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:etime_application/models/global.dart' as global;

import '../main.dart';

var title;
var body;
var time;
var image;
var buttonTitle;
var buttonUrl;
//фоновое прослушивание уведомлений
//Делаем вызов функции Firebase  в фоновом процессе
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  setupFcm();

  if (message.notification != null) {
    global.notificationList.add(NotificationModel(
        title: message.notification!.title,
        description: message.notification!.body,
        imagePath: message.data['image'],
        isRead: false,
        buttonTitle: message.data['button_title'],
        buttonUrl: message.data['button_url'],
        dateTime: message.data['created_date']));
    title = message.notification!.title;
    body = message.notification!.body;
    image = message.data['image'];
    time = message.data['time'];
    buttonTitle = message.data['button_title'];
    buttonUrl = message.data['button_url'];

    saveNotificationItemsToLocalBase(global.notificationList);
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'custom_notification_channel_id',
  'Notification',
  description: 'notifications from Your App Name.',
  importance: Importance.high,
);

void setupFcm() async {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@drawable/notification_icon');
  var initializationSettingsIOs = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true);
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOs,
  );

  //when the app is in foreground state and you click on notification.
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) {
    if (payload != null) {
      Map<String, dynamic> data = json.decode(payload);
      goToNextScreen(data);
    }
  });

  //When the app is terminated, i.e., app is neither in foreground or background.
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    //Its compulsory to check if RemoteMessage instance is null or not.
    if (message != null) {
      final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      final String? notificationString = prefs.getString('notificationItems');
      final String? balanceNotificationString =
          prefs.getString('balanceNotificationItems');

      if (notificationString == null || global.notificationList == null) {
        global.notificationList = [];
        if (kDebugMode) {
          print('Уведомлений нет');
        }
      } else {
        if (kDebugMode) {
          print('Уведомления есть');
        }
        global.notificationList = NotificationModel.decode(notificationString);
      }

      global.notificationList.add(NotificationModel(
          title: message.notification!.title,
          description: message.notification!.body,
          imagePath: message.data['image'],
          isRead: false,
          buttonTitle: message.data['button_title'],
          buttonUrl: message.data['button_url'],
          dateTime: message.data['created_date']));

      saveNotificationItemsToLocalBase(global.notificationList);

      goToNextScreen(message.data);
    }
  });

  //When the app is in the background, but not terminated.
  FirebaseMessaging.onMessageOpenedApp.listen(
    (event) {
      if (event.notification != null) {
        global.notificationList.add(NotificationModel(
            title: event.notification!.title,
            description: event.notification!.body,
            imagePath: event.data['image'],
            isRead: false,
            buttonTitle: event.data['button_title'],
            buttonUrl: event.data['button_url'],
            dateTime: event.data['created_date']));

        saveNotificationItemsToLocalBase(global.notificationList);
      }
      goToNextScreen(event.data);
    },
    cancelOnError: false,
    onDone: () {},
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      global.notificationList.add(NotificationModel(
          title: message.notification!.title,
          description: message.notification!.body,
          imagePath: message.data['image'],
          isRead: false,
          buttonTitle: message.data['button_title'],
          buttonUrl: message.data['button_url'],
          dateTime: message.data['created_date']));

      saveNotificationItemsToLocalBase(global.notificationList);

      if (android.imageUrl != null && android.imageUrl!.trim().isNotEmpty) {
        final String? largeIcon = await _base64encodedImage(
          android.imageUrl,
        );

        final BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(largeIcon!),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
          contentTitle: notification.title,
          htmlFormatContentTitle: true,
          summaryText: notification.body,
          htmlFormatSummaryText: true,
          hideExpandedLargeIcon: true,
        );

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'notification_icon',
              //color: primaryColor,
              importance: Importance.max,
              priority: Priority.high,
              largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
              styleInformation: bigPictureStyleInformation,
            ),
          ),
          payload: json.encode(message.data),
        );
      } else {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'notification_icon',
              //color: primaryColor,
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: json.encode(message.data),
        );
      }
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> deleteFcmToken() async {
  return await FirebaseMessaging.instance.deleteToken();
}

Future<String?> getFcmToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  return Future.value(token);
}

void goToNextScreen(Map<String, dynamic> data) {
  if (data['click_action'] != null) {
    switch (data['click_action']) {
      case "notification_screen":
        title = data['title'];
        body = data['body'];
        time = data['time'];
        image = data['image'];
        buttonTitle = data['button_title'];
        buttonUrl = data['button_url'];
        // if (global.notificationExist == false) {
        //   navigatorKey.currentState.pushNamed(
        //     NotificationDetailScreen(
        //       titleNotification: data['title'],
        //       description: data['body'],
        //       imagePath: data['image'],
        //       buttonTitle: data['button_title'],
        //       buttonUrl: data['button_url'],
        //     ).routeName,
        //   );
        // }

        // navigatorKey.currentState.pushNamed(SplashScreen(
        //   title: data['title'],
        //   body: data['body'],
        //   imageUrl: data['image'],
        // ).routeName);

        break;
      case "second_screen":
        break;
      case "sample_screen":
    }
    return;
  }
}

Future<String?> _base64encodedImage(String? url) async {
  final http.Response response = await http.get(Uri.parse(url!));
  final String? base64Data = base64Encode(response.bodyBytes);
  return base64Data;
}
