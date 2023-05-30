import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etime_application/helpers/firebase_messaging.dart';
import 'package:etime_application/models/profile_model.dart';
import 'package:etime_application/repository/firestore_service.dart';
import 'package:etime_application/screens/SplashScreen.dart';
import 'package:etime_application/widgets/AuthForm.dart';
import 'package:etime_application/widgets/CardWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BonusesCardScreen extends StatefulWidget {
  const BonusesCardScreen({super.key});

  @override
  State<BonusesCardScreen> createState() => _BonusesCardScreenState();
}

class _BonusesCardScreenState extends State<BonusesCardScreen>
    with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebaseDB = FirebaseFirestore.instance;
  static ProfileModel currentUser = ProfileModel();
  static FirebaseAuth? auth;
  bool isLoadUser = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    auth = _auth;
    _initCurrentUser();
    super.initState();
  }

  _initCurrentUser() async {
    print('Инициируем пользователя');
    print('состояние авторизации: ${auth?.currentUser?.uid.isNotEmpty}');
    if (auth?.currentUser?.uid.isNotEmpty ?? false) {
      bool value =
          await FirestoreService.initCurrentUser(auth?.currentUser?.uid);
      print('Значение value: $value');
      setState(() {
        isLoadUser = value;
      });
    } else {
      setState(() {
        isLoadUser = false;
      });
    }
    if (isLoadUser) {
      FirestoreService.getUserById(auth?.currentUser?.uid).then((value) {
        if (value != null) {
          setState(() {
            currentUser = ProfileModel.fromJson(value as Map<dynamic, dynamic>);
          });
        }
      });
    }
  }

  static Future updateCurrentUser() async {
    if (auth?.currentUser?.uid.isNotEmpty ?? false) {
      await FirestoreService.getUserById(auth?.currentUser?.uid).then((value) {
        currentUser = ProfileModel.fromJson(value as Map<dynamic, dynamic>);
      });
      return currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                future: Firebase.initializeApp(),
                builder: (context, snapshot) {
                  print('Снапшот ${snapshot.data}');
                  if (snapshot.hasError) {
                    print('error');
                  } else {
                    if (currentUser.uid != '') {
                      print('Текущий пользователь: ${currentUser.uid}');
                      // FirebaseMessagingService().getToken().then((value) {
                      //   firebaseDB
                      //       .collection('users')
                      //       .doc(currentUser.uid)
                      //       .update({
                      //     'fcmToken': value, // John Doe
                      //   });
                      // });
                      //Здесь возвращается нижняя панель навигации
                      return CardWidget(user: currentUser);
                    } else if (!isLoadUser) {
                      return AuthForm();
                    } else {
                      return SplashScreen();
                    }

                    //return _auth.currentUser != null ? BottomNavigation() : SplashScreenChat();
                  }

                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })));
  }
}
