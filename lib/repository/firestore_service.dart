import 'dart:convert';
import 'dart:developer';
import 'package:etime_application/helpers/firebase_constants.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/profile_model.dart';

class FirestoreService {
  static String _serverKey =
      'AAAAmYOGQwE:APA91bGeRhKoVYPVhpdLfMUdkpeh2vTDEg44rQe2S9Zv3VzkVkUUJcMMvJW17342D7QGFJArlDBUtYR7CYNbqsVmZq6i4c8bsw7dY0_D2RclmZ_1OJeTkTW8jzHYtdpgM49lYqvBKnHp';

  static const String USERS = 'users';

  static Future<bool> initCurrentUser(String? uid) async {
    try {
      bool value =
          await fbFirestore.collection(USERS).doc(uid).get().then((result) {
        if (result.exists) {
          return true;
        } else {
          return false;
        }
      });
      return value;
    } catch (e) {
      return false;
    }
  }

  static Future<Object?> getUserById(String? uid) async {
    DocumentSnapshot doc = await fbFirestore.collection(USERS).doc(uid).get();
    return doc.data();
  }
}
