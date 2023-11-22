import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';

class PhoneStateScreen extends StatefulWidget {
  const PhoneStateScreen({Key? key}) : super(key: key);

  @override
  State<PhoneStateScreen> createState() => _PhoneStateScreenState();
}

class _PhoneStateScreenState extends State<PhoneStateScreen> {
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
        title: const Text("Phone State"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Platform.isAndroid)
              MaterialButton(
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
