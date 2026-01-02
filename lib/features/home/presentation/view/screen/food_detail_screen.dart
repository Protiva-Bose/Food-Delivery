import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../buyer/cart/presentation/view/screens/order_confirmation_screen.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  final String userName;
  final String userId;

  const FoodDetailsScreen({
    super.key,
    required this.item,
    required this.userName,
    required this.userId,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final String title = widget.item['title'] ?? 'Food Item';
    final String description = widget.item['description'] ??
        '''🍔 Burger Description
A delicious classic chicken burger made with a juicy, perfectly seasoned chicken patty, layered inside a soft toasted sesame bun. Topped with fresh lettuce, tomato, onion rings, pickles, and melted cheddar cheese. Creamy mayo, mustard, and ketchup for extra flavor.''';
    final String price = widget.item['price'] ?? '80';
    final String weight = widget.item['weight'] ?? '120 g';
    final bool isVeg = widget.item['isVeg'] ?? true;
    final String icon = widget.item['icon'] ?? 'assets/icons/fast_food.png';
    final String stallName = widget.item['stallName'] ?? 'Default Stall';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: 280.h,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFE0B2), Color(0xFFFFF3E0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Hero(
                    tag: icon,
                    child: Container(
                      width: 180.w,
                      height: 180.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.4),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.asset(
                            icon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.merriweather(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: isVeg ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          isVeg ? "Veg" : "Non-Veg",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  SizedBox(
                    width: 320.w,
                    child: Text(textAlign: TextAlign.start,
                      description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                  Text('Fast Food Stall',style: GoogleFonts.merriweather(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.w800),),
                  SizedBox(height: 15.h),

                  Row(
                    children: [
                      _infoCard(title: "Price", value: price, icon: 'assets/icons/price_icon.png'),
                      SizedBox(width: 12.w),
                      _infoCard(title: "Weight", value: weight, icon: 'assets/icons/weight_icon.png'),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  SizedBox(height: 32.h),

                  Container(
                    width: double.infinity,
                    height: 52.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF38E6FF), Color(0xFF10454C)],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderConfirmationScreen(
                              stallName: stallName,
                              selectedFoods: [
                                {
                                  "name": title,
                                  "price": double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0,
                                  "weight": weight,
                                  "isVeg": isVeg,
                                  "quantity": quantity,
                                }
                              ],
                              userName: widget.userName,
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({required String title, required String value, required String icon}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color:  Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [BoxShadow(color: Color(0xFFFFE0B2), blurRadius: 5, offset: const Offset(0, 5))],
        ),
        child: Column(
          children: [
            Image.asset(icon, width: 40.w, height: 40.h),
            SizedBox(height: 8.h),
            Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12.sp)),
            SizedBox(height: 4.h),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}
