import 'dart:io';

import 'package:all_in_one/page_name.dart';
import 'package:all_in_one/utilities/my_share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                // Navigate back to the first screen by popping the current route
                // off the stack.
              //  SystemNavigator.pop();
                Navigator.of(context).pop(true);
               // Navigator.of(context, rootNavigator: true).pop(context);
                /*if(!isLongedIn){
                  Navigator.pop(context);
                }else{

                }*/
                //Navigator.of(context).pushNamed( PageName.firstPage);
              },
              child: const Text('Go back!'),
            ),

            ElevatedButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                // Navigate back to the first screen by popping the current route
                // off the stack.
                MySharedPreferences.saveBoolData(MySharedPreferences.isLongedIn, false);
               // Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    PageName.firstPage, (Route<dynamic> route) => false);
              },
              child: const Text('Go back and Clear Session'),
            ),
          ],
        ),
      ),
    );
  }
}
