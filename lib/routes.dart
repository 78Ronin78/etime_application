import 'package:etime_application/screens/RegistrationScreen.dart';
import 'package:etime_application/widgets/BottomNavigationWidget.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;
    switch (settings.name) {
      case 'tabNavigator':
        return MaterialPageRoute(builder: (_) => BottomNavigationWidget());
      case 'registrationScreen':
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
