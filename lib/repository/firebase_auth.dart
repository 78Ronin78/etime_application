import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etime_application/helpers/firebase_constants.dart';
import 'package:etime_application/helpers/firebase_messaging.dart';
import 'package:etime_application/helpers/message_exception.dart';
import 'package:etime_application/models/profile_model.dart';
import 'package:etime_application/widgets/BottomNavigationWidget.dart';
import 'package:etime_application/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FireBaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (_) {
      throw MessageException('Ошибка. Не удалось авторизовать аккаунт');
      CustomSnackBar(
          context,
          const Text('Ошибка. Не удалось авторизовать аккаунт'),
          Colors.lightGreen);
    }
  }

  Future<bool> auth(String email, String password, BuildContext context) async {
    try {
      bool result = false;
      var auth = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (auth.user != null) {
        result = await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.user?.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          return documentSnapshot.exists;
        });
      }
      return result;
      // throw MessageException('Пользователь не существует');
    } on FirebaseAuthException catch (_) {
      throw MessageException('Неверный логин или пароль');

      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Неверный логин или пароль')));
      // CustomSnackBar(
      //     context, const Text('Неверный логин или пароль'), Colors.lightGreen);
    }
  }

  Future signinWithCredential(AuthCredential credential,
      {bool verified = true}) async {
    //Sign in to Firebase
    final result = _auth.signInWithCredential(credential);
    print(result);
  }

  _redirectAuthUser(BuildContext context) async {
    // DocumentSnapshot documentSnapshot =
    //     await fbFirestore.collection('users').doc(_auth.currentUser.uid).get();
    // var user;
    // if (documentSnapshot != null && documentSnapshot.exists) {
    //   //user = ProfileModel.fromJson(documentSnapshot.data());
    //   if (user.name != null) {
    //     Navigator.pushNamed(context, 'tabNavigator');
    //   } else {
    //     Navigator.pushNamed(context, 'registrationScreen');
    //   }
    // } else {
    //   Navigator.pushNamed(context, 'registrationScreen');
    // }
  }

  static Future<Object> addUser(
      {required String name,
      required String surname,
      required String phone,
      required int gender,
      required int age,
      required String uid,
      required String city,
      required BuildContext context}) async {
    var today = DateTime.now().toUtc();
    String? fcmToken = await FirebaseMessagingService().getToken();
    return fbFirestore.collection('users').doc(uid).set({
      'name': name, //
      'surname': surname,
      'phone': phone,
      'registration_date': today,
      'gender': gender, //
      'age': age,
      'city': city,
      'uid': uid, //
    }).then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, 'tabNavigator', (Route<dynamic> route) => false);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Профиль успешно зарегистрирован')));
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => BottomNavigationWidget(),
      //   ),
      // );
    }).catchError((error) => print("Failed to add user: $error"));
  }
}

FireBaseAuth fbAuth = FireBaseAuth();
