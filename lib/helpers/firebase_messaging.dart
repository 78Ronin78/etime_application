import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._();

  factory FirebaseMessagingService() => _instance;

  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._();

  final FlutterLocalNotificationsPlugin _flnp =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    enableVibration: true,
    playSound: true,
  );

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> init() async {
    if (!_initialized) {
      _firebaseMessaging.requestPermission();
      try {
        FirebaseMessaging.onMessage.listen(_notificationOnMessage);
        var initializationSettingsAndroid =
            AndroidInitializationSettings('app_icon');
        var initializationSettingsIOs = const IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true);
        var initializationSettings = InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOs);
        await _flnp.initialize(initializationSettings);
      } catch (e) {
        print('configureFirebase error: $e');
      }

      _initialized = true;
    }
  }

  Future _notificationOnMessage(RemoteMessage message) async {
    // log("onMessage: $message");
    // _showLocal(message);
  }

  _showLocal(RemoteMessage message) {
    _flnp.show(
        message.hashCode,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              icon: 'app_icon',
            ),
            iOS: IOSNotificationDetails(
              presentAlert: true,
              presentBadge: true,
            )));
  }
}
