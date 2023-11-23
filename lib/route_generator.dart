import 'package:all_in_one/page_name.dart';
import 'package:all_in_one/screens/call_status_screen.dart';
import 'package:all_in_one/screens/first_screen.dart';
import 'package:all_in_one/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case PageName.firstPage:
        return MaterialPageRoute(builder: (_) => const FirstScreen());
      case PageName.home:
        // Validation of correct data type
        //if (args is String) {
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
              // data: args,
              ),
        );
        // }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      case PageName.callStatus:
        return MaterialPageRoute(builder: (_) => const CallStatusScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}