import 'package:all_in_one/app_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AppService>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  authService.loginState = true;
                },
                child: const Text("Log in"),
              ),

              TextButton(
                onPressed: () {
                  authService.onboarding = false;
                  //context.pop();
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
