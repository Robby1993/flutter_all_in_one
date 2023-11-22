import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';

import 'back_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "Stop Service";

  PhoneState status = PhoneState.nothing();
  bool granted = false;

  Future<bool> requestPermission() async {
    var status = await Permission.phone.request();
    var value = false;
    if (status == PermissionStatus.denied) {
      value = false;
    } else if (status == PermissionStatus.restricted) {
      value = false;
    } else if (status == PermissionStatus.limited) {
      value = false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      value = false;
    } else if (status == PermissionStatus.provisional) {
      value = true;
    } else if (status == PermissionStatus.granted) {
      value = true;
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) setStream();
  }
  void setStream() {
    PhoneState.stream.listen((event) {
      setState(() {
        if (event != null) {
          status = event;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                FlutterBackgroundService().invoke('setAsForeground');
              },
              child: const Text("Foreground Service"),
            ), // ElevatedButton
            ElevatedButton(
              onPressed: () {
                FlutterBackgroundService().invoke('setAsBackground');
              },
              child: const Text("Background Service"),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke("stopService");
                } else {
                  service.startService();
                }
                if (!isRunning) {
                  text = "Stop Service";
                } else {
                  text = "Start Service";
                }
                setState(() {

                });
              },
              child: Text(text),
            ),
            if (Platform.isAndroid)
              ElevatedButton(
                onPressed: !granted
                    ? () async {
                  bool temp = await requestPermission();
                  setState(() {
                    granted = temp;
                    if (granted) {
                      setStream();
                    }
                  });
                }
                    : null,
                child: const Text("Request permission of Phone"),
              ),

            const Text(
              "Status of call",
              style: TextStyle(fontSize: 24),
            ),
            if (status.status == PhoneStateStatus.CALL_INCOMING ||
                status.status == PhoneStateStatus.CALL_STARTED)
              Text(
                "Number: ${status.number}",
                style: const TextStyle(fontSize: 24),
              ),
            Icon(
              getIcons(),
              color: getColor(),
              size: 80,
            )
          ],
        ),
      ),
    );
  }

  IconData getIcons() {
    var value = Icons.clear;
    if (status.status == PhoneStateStatus.NOTHING) {
      value = Icons.clear;
    } else if (status.status == PhoneStateStatus.CALL_INCOMING) {
      value = Icons.add_call;
    } else if (status.status == PhoneStateStatus.CALL_STARTED) {
      value = Icons.call;
    } else if (status.status == PhoneStateStatus.CALL_ENDED) {
      value = Icons.call_end;
    }
    return value;
  }

  Color getColor() {
    var value = Colors.red;
    if (status.status == PhoneStateStatus.NOTHING) {
      value = Colors.red;
    } else if (status.status == PhoneStateStatus.CALL_INCOMING) {
      value = Colors.green;
    } else if (status.status == PhoneStateStatus.CALL_STARTED) {
      value = Colors.orange;
    } else if (status.status == PhoneStateStatus.CALL_ENDED) {
      value = Colors.red;
    }
    return value;
  }
}
