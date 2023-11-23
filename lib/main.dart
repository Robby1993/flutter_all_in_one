import 'dart:io';

import 'package:all_in_one/page_name.dart';
import 'package:all_in_one/route_generator.dart';
import 'package:all_in_one/screens/first_screen.dart';
import 'package:all_in_one/utilities/my_share_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:url_strategy/url_strategy.dart';

import 'helper/link_handler.dart';
import 'services/back_services.dart';

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
  bool isLongedIn =
      await MySharedPreferences.getBoolData(MySharedPreferences.isLongedIn);
  // Register our protocol only on Windows platform
  //_registerWindowsProtocol();
  setPathUrlStrategy();
  runApp(MyApp(isLongedIn));
}

class MyApp extends StatefulWidget {
  bool isLongedIn;

  MyApp(this.isLongedIn, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /* final RoutemasterDelegate _routemaster = RoutemasterDelegate(
    routesBuilder: (context) {
      if (Provider.of<ProAppSettings>(context).isLoggedIn) {
        return loggedInRoutes;
      } else {
        return loggedOutRoutes;
      }
    },
  );*/

 // late final LinkHandler _linkHandler = LinkHandler(onLink: (link) => _routemaster.push(link));
  late final LinkHandler _linkHandler = LinkHandler(onLink: (link){
    //_navigatorKey.currentState?.pushNamed(uri.fragment);
   // _navigatorKey.currentState?.pushNamed(link);
  });
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    _linkHandler.init();
  }

  @override
  void dispose() {
    _linkHandler.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: widget.isLongedIn ? PageName.home : PageName.firstPage,
      //initialRoute: PageName.firstPage,
      onGenerateRoute: RouteGenerator.generateRoute,
      /*onGenerateRoute: (RouteSettings settings) {
        Widget routeWidget = const FirstScreen();

        // Mimic web routing
        final routeName = settings.name;
        if (routeName != null) {
          *//*if (routeName.startsWith('/book/')) {
            // Navigated to /book/:id
            routeWidget = customScreen(
              routeName.substring(routeName.indexOf('/book/')),
            );
          } else if (routeName == '/book') {
            // Navigated to /book without other parameters
            routeWidget = customScreen("None");
          }*//*
        }

        return MaterialPageRoute(
          builder: (context) => routeWidget,
          settings: settings,
          fullscreenDialog: true,
        );
      },*/
    );
  }

  void _registerWindowsProtocol() {
    // Register our protocol only on Windows platform
    if (!kIsWeb) {
      if (Platform.isWindows) {
       // registerProtocolHandler("kWindowsScheme");
        //unregisterProtocolHandler("kWindowsScheme"),
      }
    }
  }
}

