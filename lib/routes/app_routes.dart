import 'package:flutter/material.dart';
import '../presentation/settings/settings.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/recipe_list/recipe_list.dart';
import '../presentation/device_pairing_onboarding/device_pairing_onboarding.dart';
import '../presentation/device_control/device_control.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String settings = '/settings';
  static const String splash = '/splash-screen';
  static const String homeDashboard = '/home-dashboard';
  static const String recipeList = '/recipe-list';
  static const String devicePairingOnboarding = '/device-pairing-onboarding';
  static const String deviceControl = '/device-control';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const HomeDashboard(),
    settings: (context) => const Settings(),
    splash: (context) => const SplashScreen(),
    homeDashboard: (context) => const HomeDashboard(),
    recipeList: (context) => const RecipeList(),
    devicePairingOnboarding: (context) => const DevicePairingOnboarding(),
    deviceControl: (context) => const DeviceControl(),
    // TODO: Add your other routes here
  };
}
