import 'package:etime_application/helpers/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 13, 66),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                "assets/logo/applogo.png",
                height: 200.0.toAdaptive(context),
                fit: BoxFit.cover,
              ),
            ),
            CircularProgressIndicator(color: Color.fromARGB(255, 249, 22, 112)),
          ],
        ),
      ),
    );
  }
}
