import 'package:flutter/cupertino.dart';

import '../../core/constant/route_names.dart';
import '../../features/categories/categories_screen.dart';
import '../../features/home/presentation/view/screen/home_screen.dart';
import '../../features/parent/parent_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRoutes {
  static const String initialRoute = RouteNames.splashScreen;

  static final Map<String, WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.home: (context) => const HomeScreen(),
    RouteNames.categoriesScreen: (context) => const CategoriesScreen(),

  };
}