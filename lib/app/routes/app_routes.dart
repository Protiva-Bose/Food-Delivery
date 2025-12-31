import 'package:flutter/cupertino.dart';
import '../../core/constant/route_names.dart';
import '../../features/auth/presentation/view/screens/forgot_password.dart';
import '../../features/auth/presentation/view/screens/login_screen.dart';
import '../../features/auth/presentation/view/screens/set_new_password.dart';
import '../../features/auth/view/screens/otp_Screen.dart';
import '../../features/cart/presentation/view/cart_screen.dart';
import '../../features/categories/presentation/view/categories_see_all_screen.dart';
import '../../features/home/presentation/view/screen/home_screen.dart';
import '../../features/home/presentation/view/screen/see_all_products_screen.dart';
import '../../features/onboarding/presentation/view/onboarding_screen.dart';
import '../../features/parent/presentation/view/parent_screen.dart';
import '../../features/profile/presentation/view/screens/user_info.dart';
import '../../features/splash/presentation/view/splash_screen.dart';

class AppRoutes {
  static const String initialRoute = RouteNames.splashScreen;

  static final Map<String, WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.home: (context) =>  HomeScreen(),
    RouteNames.categoriesScreen: (context) => const CategoriesScreen(),
    RouteNames.foodGridScreen: (context) => const FoodGridScreen(),
    RouteNames.userInfoScreen: (context) =>
        UserInfoScreen(userInfo: ModalRoute.of(context)!.settings.arguments as Map<String, String>),
    RouteNames.cartScreen: (context) => CartScreen(),
    RouteNames.foodOnboardingScreen: (context) => FoodOnboardingScreen(),
    RouteNames.loginScreen: (context) => LoginScreen(),
    RouteNames.forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    RouteNames.setNewPasswordScreen: (context) => SetNewPasswordScreen(),
    RouteNames.otpScreen: (context) => OtpScreen(email: '',),

  };
}