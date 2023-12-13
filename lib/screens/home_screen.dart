import 'dart:io';

import 'package:all_in_one/page_name.dart';
import 'package:all_in_one/utilities/my_share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_router.dart';
import '../app_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLongedIn = false;
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
     isLongedIn =
    await MySharedPreferences.getBoolData(MySharedPreferences.isLongedIn);
  }

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                context.go(
                  PageName.callStatus,
                  extra: 'callStatus',
                );
                /*Navigator.pushNamed(
                  context,
                  PageName.callStatus,
                  arguments: 'callStatus',
                );*/
              },
              child: const Text('Call Status screen'),
            ),
            ElevatedButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                context.pushNamed(PageName.news, pathParameters: {
                  "id": "dwirandyh",
                  "path": "flutter-deeplink-example"
                });
              },
              child: const Text('Go News Screen!'),
            ),

            ElevatedButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                // Navigate back to the first screen by popping the current route
                // off the stack.
               // MySharedPreferences.saveBoolData(MySharedPreferences.isLongedIn, false);
               // MySharedPreferences.saveBoolData(MySharedPreferences.isProfileUpdate, false);
                appService.onLogout();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
