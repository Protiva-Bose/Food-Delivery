import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/route_names.dart';
import '../screen/food_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final quantity = 1;
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> foodItem = {
      "title": "French fry with Mango juice",
      "description":
      "Crispy golden french fries served with refreshing chilled mango juice. A perfect combo for a quick snack!",
      "price": "\$100",
      "weight": "350g + 250ml",
      "isVeg": true,
      "icon": "assets/icons/foods.png",
    };
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FoodDetailsScreen(
                      item: {
                        "title": "French fry with Mango juice",
                        "description": '''🍟 French Fries Description
Crispy, golden-brown French fries made from fresh potatoes, perfectly fried to a crunchy exterior and soft, fluffy interior. Lightly salted for taste, they are served hot and crispy. Optional toppings include ketchup, mayonnaise, cheese, or chili sauce for extra flavor. Perfect as a snack or side with burgers, sandwiches, or your favorite meal.''',
                        "price": "\$100",
                        "weight": "250g",
                        "isVeg": false,
                        "icon": "assets/icons/foods.png",
                        "stallName": "Burger Stall",
                        "userName": "John Doe",
                        "userId": "12345",
                        "quantity": quantity,
                      }, userName: '', userId: '',
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 5.w),
                width: 180.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90.h,
                      decoration: const BoxDecoration(color: Color(0xFFE6F7F8)),
                      child: Center(
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Image.asset(
                            'assets/icons/foods.png',
                            scale: 1.5,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'French fry with Mango juice',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              const Text(
                                '\$100',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF00A9B7),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00A9B7),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:Image.asset('assets/icons/buy_icon.png',scale: 6.5,color: Colors.white,)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
