import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:etime_application/models/notification_model.dart';
import 'package:etime_application/models/profile_model.dart';
import 'package:etime_application/repository/save_values_to_local_base.dart';
import 'package:etime_application/routes.dart';
import 'package:etime_application/widgets/BottomNavigationWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:etime_application/helpers/firebase_notification_helper.dart';
import 'package:etime_application/models/global.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

//фоновое прослушивание уведомлений
//Делаем вызов функции Firebase  в фоновом процессе
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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
      dateTime: message.data['created_date'],
      isRead: false,
      buttonTitle: message.data['button_title'],
      buttonUrl: message.data['button_url'],
    ));

    title = message.notification!.title;
    body = message.notification!.body;
    image = message.data['image'];
    time = message.data['time'];
    buttonTitle = message.data['button_title'];
    buttonUrl = message.data['button_url'];

    saveNotificationItemsToLocalBase(global.notificationList);
  }
}

//Создаем переменную для локальных уведомлений
final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  global.firebaseToken = prefs.getString('firebase_token');
  final String? notificationString = prefs.getString('notificationItems');
  if (notificationString == null || global.notificationList == null) {
    global.notificationList = [];
  } else {
    global.notificationList = NotificationModel.decode(notificationString);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    initPlatformState();
    setupFcm();
    super.initState();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
    if (_deviceData['brand'] == 'huawei') {
      if (kDebugMode) {
        print('Инициализация huawei пушей');
      }
      //_initHuaweiPushKit(); Реализовать пуши для Huawei
    }
    if (_deviceData['model'] == 'iPhone') {
      if (kDebugMode) {
        print('Инициализация iOS пушей');
      }
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      _initFirebaseIOSPushSdk();
    }
    if (_deviceData['brand'] != 'huawei' && _deviceData['model'] != 'iPhone') {
      if (kDebugMode) {
        print('Инициализация android пушей');
      }
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      _initFirebaseAndoridPushSdk();
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  _initFirebaseAndoridPushSdk() async {
    if (global.firebaseToken == null || global.firebaseToken == '') {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      saveFirebasetokenToLocalBase(fcmToken!);
      global.firebaseToken = fcmToken;
      if (kDebugMode) {
        print(' создан новый fcmToken: ${global.firebaseToken}');
      }
    } else {
      global.firebaseToken = global.firebaseToken;
      if (kDebugMode) {
        print('взят существующий fcmToken: ${global.firebaseToken}');
      }
    }
    //Когда работает фоновый режим
    FirebaseMessaging.onBackgroundMessage((message) async {
      if (message.notification != null) {
        global.notificationList.add(NotificationModel(
          title: message.notification!.title,
          description: message.notification!.body,
          imagePath: message.data['image'],
          dateTime: message.data['created_date'],
          isRead: false,
          buttonTitle: message.data['button_title'],
          buttonUrl: message.data['button_url'],
        ));
        setState(() {
          title = message.notification!.title;
          body = message.notification!.body;
          image = message.data['image'];
          time = message.data['time'];
          buttonTitle = message.data['button_title'];
          buttonUrl = message.data['button_url'];
        });
        saveNotificationItemsToLocalBase(global.notificationList);
      }
    });
  }

  _initFirebaseIOSPushSdk() async {
    if (global.firebaseToken == null || global.firebaseToken == '') {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      saveFirebasetokenToLocalBase(fcmToken!);
      global.firebaseToken = fcmToken;
      if (kDebugMode) {
        print(' создан новый fcmToken: ${global.firebaseToken}');
      }
    } else {
      global.firebaseToken = global.firebaseToken;
      if (kDebugMode) {
        print('взят существующий fcmToken: ${global.firebaseToken}');
      }
    }
    //Когда работает фоновый режим
    FirebaseMessaging.onBackgroundMessage((message) async {
      if (message.notification != null) {
        global.notificationList.add(NotificationModel(
          title: message.notification!.title,
          description: message.notification!.body,
          imagePath: message.data['image'],
          dateTime: message.data['created_date'],
          isRead: false,
          buttonTitle: message.data['button_title'],
          buttonUrl: message.data['button_url'],
        ));
        setState(() {
          title = message.notification!.title;
          body = message.notification!.body;
          image = message.data['image'];
          time = message.data['time'];
          buttonTitle = message.data['button_title'];
          buttonUrl = message.data['button_url'];
        });
        saveNotificationItemsToLocalBase(global.notificationList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Приложение BOOTCAMP | Братск',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigationWidget(),
    );
  }
}
