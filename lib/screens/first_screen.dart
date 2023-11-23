import 'package:all_in_one/page_name.dart';
import 'package:all_in_one/utilities/my_share_preference.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
    bool isLongedIn =
        await MySharedPreferences.getBoolData(MySharedPreferences.isLongedIn);
    if (isLongedIn) {
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            PageName.home,
            arguments: 'Data from first page!',
            (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(
                  context,
                  PageName.home,
                  arguments: 'Data from first page!',
                );
              },
              child: const Text('Launch screen'),
            ),
            ElevatedButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                MySharedPreferences.saveBoolData(
                    MySharedPreferences.isLongedIn, true);
                // Navigate to the second screen using a named route.
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    PageName.home,
                    arguments: 'Data from first page!',
                    (Route<dynamic> route) => false);
                // Navigator.pushNamed(context, PageName.home);
              },
              child: const Text('Launch screen with Session'),
            ),
            ElevatedButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PageName.callStatus,
                  arguments: 'callStatus',
                );
              },
              child: const Text('Call Status screen'),
            ),
          ],
        ),
      ),
    );
  }
}
