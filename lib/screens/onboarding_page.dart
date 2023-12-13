import 'package:all_in_one/app_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("On Boarding"),
              TextButton(
                onPressed: () {
                  appService.onboarding = true;
                },
                child: const Text("Login Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
