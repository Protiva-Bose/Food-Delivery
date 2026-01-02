import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../auth/presentation/view/screens/login_screen.dart';

class OnboardItem {
  final String lottie;
  final String title;
  final String subtitle;

  OnboardItem({
    required this.lottie,
    required this.title,
    required this.subtitle,
  });
}


class FoodOnboardingScreen extends StatefulWidget {
  const FoodOnboardingScreen({super.key});

  @override
  State<FoodOnboardingScreen> createState() => _FoodOnboardingScreenState();
}

class _FoodOnboardingScreenState extends State<FoodOnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardItem> pages = [
    OnboardItem(
      lottie: 'assets/json/order_food_onboarding_one.json',
      title: 'Discover Food',
      subtitle: 'Find your favorite meals from nearby stalls',
    ),
    OnboardItem(
      lottie: 'assets/json/onboarding_sec.json',
      title: 'Fast Ordering',
      subtitle: 'Order food instantly with a smooth experience',
    ),
    OnboardItem(
      lottie: 'assets/json/onboarding_third.json',
      title: 'Enjoy Meals',
      subtitle: 'Fresh & tasty food delivered to you',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF38E6FF),Color(0xFF10454C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Skip",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 16.sp),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (_, index) {
                    final item = pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          item.lottie,
                          height: 260.h,
                          width: 260.w,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: _currentIndex == index ? 22.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 55.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  onPressed: () {
                    if (_currentIndex == pages.length - 1) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _currentIndex == pages.length - 1
                        ? "Get Started"
                        : "Next",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00A9B7),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}