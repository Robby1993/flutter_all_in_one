import 'package:all_in_one/page_name.dart';
import 'package:all_in_one/screens/call_status_screen.dart';
import 'package:all_in_one/screens/edit_profile_screen.dart';
import 'package:all_in_one/screens/home_screen.dart';
import 'package:all_in_one/screens/login_screen.dart';
import 'package:all_in_one/screens/news_page.dart';
import 'package:all_in_one/screens/not_found_page.dart';
import 'package:all_in_one/screens/onboarding_page.dart';
import 'package:all_in_one/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_service.dart';

class AppRouter {
  late final AppService appService;

  AppRouter(this.appService);

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _goRouter = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: appService,
    initialLocation: PageName.home,
    routes: [
      GoRoute(
        path: PageName.home,
        name: PageName.home,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: PageName.splash,
        name: PageName.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: PageName.onBoarding,
        name: PageName.onBoarding,
        builder: (context, state) => const OnBoardingPage(),
      ),

      GoRoute(
        path: PageName.onProfile,
        name: PageName.onProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),

      GoRoute(
        path: PageName.login,
        name: PageName.login,
        builder: (context, state) => const LogInPage(),
      ),
      GoRoute(
        path: PageName.callStatus,
        name: PageName.callStatus,
        builder: (context, state) => const CallStatusScreen(),
      ),

      //https://dwirandyh.medium.com/effortless-routing-deeplink-in-flutter-using-go-router-59edd67c52a0#:~:text=Deep%20linking%20allows%20you%20to,custom%20data%2C%20like%20promotional%20codes.
      GoRoute(
        path: "${PageName.news}/:id/:path",
        // path: PageName.news,
        name: "news",
        builder: (context, state) => NewsPage(
          userId: state.pathParameters["id"].toString(),
          path: state.pathParameters["path"].toString(),
        ),
      )
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
    redirect: (context, state) {
      final isLogedIn = appService.loginState;
      final isInitialized = appService.initialized;
      final isOnboarded = appService.onboarding;
      final isOnProfile = appService.onProfile;

      final isGoingToLogin = state.matchedLocation == PageName.login;
      final isGoingToInit = state.matchedLocation == PageName.splash;
      final isGoingToOnboard = state.matchedLocation == PageName.onBoarding;
      final isGoingToOnProfile = state.matchedLocation == PageName.onProfile;

      // If not Initialized and not going to Initialized redirect to Splash
      if (!isInitialized && !isGoingToInit) {
        return PageName.splash;
        // If not onboard and not going to onboard redirect to OnBoarding
      } else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
        return PageName.onBoarding;
        // If not logedin and not going to login redirect to Login
      } else if (isInitialized &&
          isOnboarded &&
          !isLogedIn &&
          !isGoingToLogin) {
        return PageName.login;
        // If logedin and profile not edit and not going to profile redirect to profile
      } else if (isInitialized &&
          isOnboarded &&
          isLogedIn &&
          isGoingToLogin &&
          !isOnProfile &&
          !isGoingToOnProfile) {
        return PageName.onProfile;
        // If logedin and profile not edit and not going to profile redirect to profile
      } else if ((isLogedIn && isGoingToLogin) ||
          (isOnProfile && isGoingToOnProfile) ||
          (isInitialized && isGoingToInit) ||
          (isOnboarded && isGoingToOnboard)) {
        return PageName.home;
      } else {
        // Else Don't do anything
        return null;
      }
    },
  );

  GoRouter get goRouter => _goRouter;
}
