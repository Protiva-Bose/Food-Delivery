import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_bite/features/home/presentation/view/screen/slider_Screen.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/route_names.dart';
import '../widgets/category_item.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();

  Timer? _sliderTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    /// ✅ START AUTO SLIDER AFTER FIRST FRAME
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sliderTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (!_pageController.hasClients) return;

        _currentIndex = (_currentIndex + 1) % 4;

        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        setState(() {}); // update indicator
      });
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 8,
                  right: 8,
                  bottom: 8,
                ),
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Good Morning',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Protiva',
                            style: GoogleFonts.merriweather(
                              color: const Color(0xFF10454C),
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _actionIcon(Icons.people_outline),
                          const SizedBox(width: 10),
                          _actionIcon(Icons.notifications_active_outlined),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: _border(),
                        enabledBorder: _border(),
                        focusedBorder: _border(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    CarouselExample(),
                    const SizedBox(height: 12),

                    SizedBox(height: 20.h),
                    SectionHeader(title: 'All Categories', onSeeAllTap: () {Navigator.pushNamed(context, RouteNames.categoriesScreen);}),
                    SizedBox(height: 10.h),
                    Row(
                      spacing: 15,
                      children: const [
                        CategoryItem(
                          title: 'Soft Drinks',
                          iconPath: 'assets/icons/soft_drinks.png',
                        ),
                        CategoryItem(
                          title: 'Rice Item',
                          iconPath: 'assets/icons/rice_item.png',
                        ),
                        CategoryItem(
                          title: 'Fast Food',
                          iconPath: 'assets/icons/fast_food.png',
                        ),
                        CategoryItem(
                          title: 'Snacks',
                          iconPath: 'assets/icons/snacks_icon.png',
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),
                    SectionHeader(title: 'Top Sold Today', onSeeAllTap: () {  }),
                    SizedBox(height: 10.h),
                    const ProductCard(),
                    SizedBox(height: 15.h),
                    SectionHeader(title: 'Special', onSeeAllTap: () {}),
                    SizedBox(height: 10.h),
                    const ProductCard(),
                    SizedBox(height: 15.h),
                    SectionHeader(title: 'New', onSeeAllTap: () {}),
                    SizedBox(height: 10.h),
                    const ProductCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(icon, color: Colors.black),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );
  }
}
