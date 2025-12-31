import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_colors.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 5,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Column(
              spacing: 8,
              children: [
                Container(
                  width: 70.w,
                  height: 55.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Color(0xffE1FFFD),
                    border: Border.all(color: Colors.blue.shade100,
                    width: 2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/fast_food.png',
                      scale: 3,
                    ),
                  ),
                ),
                Text(
                  'Fast Food',
                  style: TextStyle(
                    color:Color(0xFF10454C),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}