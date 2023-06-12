import 'package:etime_application/models/notification_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<void> saveNotificationItemsToLocalBase(
    List<NotificationModel> notificationList) async {
  final SharedPreferences prefs = await _prefs;
  final String encodeData = NotificationModel.encode(notificationList);
  prefs.setString('notificationItems', encodeData).then((bool success) {
    if (kDebugMode) {
      print("notificationItems --> $encodeData");
    }
  });
}

Future<void> saveFirebasetokenToLocalBase(String token) async {
  final SharedPreferences prefs = await _prefs;
  if (prefs.getString('firebase_token') == null) {
    await prefs.setString('firebase_token', token).then((bool success) {
      if (kDebugMode) {
        print('saveFirebaseToken --> $token');
      }
    });
  }
}

void removeLocalBaseValues() async {
  final SharedPreferences prefs = await _prefs;
  prefs.remove('notificationItems').then((bool success) {
    if (kDebugMode) {
      print("notificationItems_removed");
    }
  });
}
