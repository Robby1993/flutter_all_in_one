import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AppService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            // Within the `FirstScreen` widget
            onPressed: () {
              authService.onProfile = true;
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
