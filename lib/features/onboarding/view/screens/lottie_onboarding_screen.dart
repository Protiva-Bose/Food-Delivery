import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieScreen extends StatefulWidget {
  const LottieScreen({super.key});

  @override
  State<LottieScreen> createState() => _LottieScreenState();
}

class _LottieScreenState extends State<LottieScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset('assets/json/congrats.json', height: 150.h, width: 150.w)
    );
  }
  Widget shimmer({
    String? name,
    required BuildContext context,
    Color? color,
    double? size,
  }) {
    return Center(
      child: Container(
        child: Lottie.asset(
          name ??  'assets/json/congrats.json',
          width: size,
          height: size,
        ),
      ),
    );
  }
}
