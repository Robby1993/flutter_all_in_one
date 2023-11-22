import 'dart:async';
import 'dart:ui';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:phone_state/phone_state.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
  );
}

@pragma('vm: entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm: entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  /// background phone stream
  PhoneState.stream.listen((status) async {
    String number = "";
    if (status.status == PhoneStateStatus.CALL_INCOMING ||
        status.status == PhoneStateStatus.CALL_STARTED) {
      number = status.number ?? "";
    } else if (status.status == PhoneStateStatus.CALL_STARTED) {
      number = "Call Stated";
    } else if (status.status == PhoneStateStatus.CALL_ENDED) {
      number = "Call Ended";
      Iterable<CallLogEntry> entries = await CallLog.query(
        number: status.number,
      );
      final lastData = entries.first;

      if (lastData.callType == CallType.missed) {
        debugPrint("PhoneState missed duration: ${lastData.duration}");
      } else if (lastData.callType == CallType.incoming) {
        debugPrint("PhoneState incoming duration: ${lastData.duration}");
      } else if (lastData.callType == CallType.outgoing) {
        debugPrint("PhoneState outgoing duration: ${lastData.duration}");
      }

      debugPrint("PhoneState lastData name: ${lastData.name}");
      debugPrint("PhoneState lastData callType: ${lastData.callType}");
      debugPrint(
          "PhoneState lastData formattedNumber: ${lastData.formattedNumber}");
      debugPrint(
          "PhoneState lastData simDisplayName: ${lastData.simDisplayName}");
      debugPrint(
          "PhoneState lastData phoneAccountId: ${lastData.phoneAccountId}");
    }
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: "${status.status}",
            content:
                "index: ${status.status.index} Number $number name: ${status.status.name}");
      }
    }
    //// perform some operation on background which in not noticeable to the used everytime
    debugPrint("background PhoneState  status: ${status.status}");
    service.invoke('update');
  });

  /*int count = 0;
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      count++;
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: "Robin", content: "Test Robin $count");
      }
    }
    //// perform some operation on background which in not noticeable to the used everytime
    debugPrint("background service running $count");
    service.invoke('update');
  });*/
}
