import 'dart:io';

import 'package:all_in_one/app_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app_router.dart';
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
  setPathUrlStrategy();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(
    MyApp(
      sharedPreferences: sharedPreferences,
    ),
  );
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

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
  late AppService appService;
  // late final LinkHandler _linkHandler = LinkHandler(onLink: (link) => _routemaster.push(link));
  late final LinkHandler _linkHandler = LinkHandler(onLink: (link) {
    //_navigatorKey.currentState?.pushNamed(uri.fragment);
    // _navigatorKey.currentState?.pushNamed(link);
  });

  @override
  void initState() {
    super.initState();
    appService = AppService(widget.sharedPreferences);
    _linkHandler.init();
  }

  @override
  void dispose() {
    _linkHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<AppService>(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter(appService)),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter = Provider.of<AppRouter>(context, listen: false).goRouter;
          return MaterialApp.router(
            title: "Router App",
            debugShowCheckedModeBanner: false,
            routeInformationProvider: goRouter.routeInformationProvider,
            routeInformationParser: goRouter.routeInformationParser,
            routerDelegate: goRouter.routerDelegate,
          );
        },
      ),
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
