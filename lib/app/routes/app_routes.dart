import 'package:flutter/cupertino.dart';
import '../../core/constant/route_names.dart';
import '../../features/auth/presentation/view/screens/forgot_password.dart';
import '../../features/auth/presentation/view/screens/login_screen.dart';
import '../../features/auth/presentation/view/screens/otp_Screen.dart';
import '../../features/auth/presentation/view/screens/set_new_password.dart';
import '../../features/buyer/cart/presentation/view/cart_screen.dart';
import '../../features/buyer/categories/presentation/view/categories_see_all_screen.dart';
import '../../features/buyer/parent/presentation/view/parent_screen.dart';
import '../../features/buyer/profile/presentation/view/screens/user_info.dart';
import '../../features/home/presentation/view/screen/food_detail_screen.dart';
import '../../features/home/presentation/view/screen/home_screen.dart';
import '../../features/home/presentation/view/screen/see_all_products_screen.dart';
import '../../features/onboarding/presentation/view/onboarding_screen.dart';
import '../../features/seller/check/presentation/view/check_screen.dart';
import '../../features/seller/parent/presentation/view/seller_parent_Screen.dart';
import '../../features/seller/profile/presentation/view/profile_screen.dart';
import '../../features/seller/profile/presentation/view/screens/graph_chart_screen.dart';
import '../../features/seller/profile/presentation/view/screens/posted_food_item_screen.dart';
import '../../features/seller/upload/presentation/view/upload_screen.dart';
import '../../features/splash/presentation/view/splash_screen.dart';

class AppRoutes {
  static const String initialRoute = RouteNames.splashScreen;

  static final Map<String, WidgetBuilder> routes = {

    // Buyer part
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.home: (context) =>  HomeScreen(),
    RouteNames.categoriesScreen: (context) => const CategoriesScreen(),
    RouteNames.foodGridScreen: (context) =>  FoodGridScreen(),
    RouteNames.userInfoScreen: (context) =>
        UserInfoScreen(userInfo: ModalRoute.of(context)!.settings.arguments as Map<String, String>),
    RouteNames.cartScreen: (context) => CartScreen(),
    RouteNames.foodOnboardingScreen: (context) => FoodOnboardingScreen(),
    RouteNames.loginScreen: (context) => LoginScreen(),
    RouteNames.forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    RouteNames.setNewPasswordScreen: (context) => SetNewPasswordScreen(),
    RouteNames.otpScreen: (context) => OtpScreen(email: '',),


    // Seller Part
    RouteNames.sellerParentScreen: (context) =>SellerParentScreen(),
    RouteNames.checkScreen: (context) =>CheckScreen(),
    RouteNames.uploadScreen: (context) =>UploadScreen(),
    RouteNames.topSellingFoodGraphScreen: (context) =>TopSellingFoodGraphScreen(),
    RouteNames.postedFoodItemScreen: (context) =>PostedFoodItemScreen(),
    RouteNames.sellerProfileScreen: (context) =>SellerProfileScreen(),
    RouteNames.foodDetailsScreen: (context) =>FoodDetailsScreen(item: {}, userName: '', userId: '',),


  };
}