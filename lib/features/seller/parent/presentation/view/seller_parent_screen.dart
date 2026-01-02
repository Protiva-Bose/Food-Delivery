import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../home/presentation/view/screen/home_screen.dart';
import '../../../check/presentation/view/check_screen.dart';
import '../../../upload/presentation/view/upload_screen.dart';
import '../../view_model/parent_view_model.dart';
import '../view_model/seller_parent_screen_viewmodel.dart';

class SellerParentScreen extends StatefulWidget {
  const SellerParentScreen({super.key});

  @override
  State<SellerParentScreen> createState() => _SellerParentScreenState();
}

class _SellerParentScreenState extends State<SellerParentScreen>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _colorAnimation = _controller.drive(
      TweenSequence<Color?>([
        TweenSequenceItem(
          tween: ColorTween(
            begin: Colors.deepPurple.shade200,
            end: Colors.blueAccent.shade100,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(
            begin: Colors.blueAccent.shade200,
            end: Colors.pinkAccent.shade200,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(
            begin: Colors.pinkAccent.shade200,
            end: Colors.deepPurple.shade200,
          ),
          weight: 1,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleNavChange(int index) {
    context.read<SellerParentScreenViewmodel>().changeIndex(index);

    setState(() {
      _isPressed = index == 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SellerParentScreenViewmodel>(
      builder: (__, navParentProvider, child) {
        final List<Widget> pages = [
           HomeScreen(),
           UploadScreen(),
           CheckScreen(),
           CheckScreen(),
        ];

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: navParentProvider.selectedIndex,
                    children: pages,
                  ),
                ),
                Container(
                  height: 75.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 15.w),

                      Expanded(
                        child: _buildNavigationDestinationBar(
                          context: context,
                          index: 0,
                          label: 'Home',
                          iconPath: 'assets/icons/home.png',
                          selectedIconPath: 'assets/icons/home.png',
                          isSelected: navParentProvider.selectedIndex == 0,
                          selectedIconColor: Colors.black,
                          unselectedIconColor: Colors.grey.shade900,
                          width: 14.w,
                          height: 14.h,
                          scale: 5,
                        ),
                      ),

                      Expanded(
                        child: _buildNavigationDestinationBar(
                          context: context,
                          index: 1,
                          label: 'Upload',
                          iconPath: 'assets/icons/uploads_icons.png',
                          selectedIconPath: 'assets/icons/uploads_icons.png',
                          isSelected: navParentProvider.selectedIndex == 1,
                          selectedIconColor: Colors.black,
                          unselectedIconColor: Colors.grey.shade900,
                          width: 15.w,
                          height: 15.h,
                          scale: 4.9,
                        ),
                      ),

                      Expanded(
                        child: _buildNavigationDestinationBar(
                          context: context,
                          index: 2,
                          label: 'Check',
                          iconPath: 'assets/icons/check_icon.png',
                          selectedIconPath: 'assets/icons/check_icon.png',
                          isSelected: navParentProvider.selectedIndex == 2,
                          selectedIconColor: Colors.black,
                          unselectedIconColor: Colors.grey.shade900,
                          width: 23.w,
                          height: 23.h,
                          scale: 4.2,
                        ),
                      ),

                      Expanded(
                        child: _buildNavigationDestinationBar(
                          context: context,
                          index: 3,
                          label: 'Profile',
                          iconPath: 'assets/icons/profile_icon.png',
                          selectedIconPath: 'assets/icons/profile_icon.png',
                          isSelected: navParentProvider.selectedIndex == 3,
                          selectedIconColor: Colors.black,
                          unselectedIconColor: Colors.grey.shade900,
                          width: 15.w,
                          height: 15.h,
                          scale: 4.2,
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationDestinationBar({
    required BuildContext context,
    required int index,
    required double scale,
    required double width,
    required double height,
    required String label,
    required String iconPath,
    required bool isSelected,
    required String selectedIconPath,
    Color selectedIconColor = Colors.white,
    Color unselectedIconColor =  Colors.grey,
  }) {
    return SizedBox(
      width: 50.w,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => _handleNavChange(index),
              child: Image.asset(iconPath,color: isSelected? Color(0xff00C7C0) : Colors.grey.shade600,scale: scale,),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Color(0xff00C7C0) : Colors.black38,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}