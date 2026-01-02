import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_bite/features/home/presentation/view/screen/food_detail_screen.dart';
import '../../../../buyer/parent/presentation/view/parent_screen.dart';

class FoodGridScreen extends StatefulWidget {

   const FoodGridScreen({super.key});

  @override
  State<FoodGridScreen> createState() => _FoodGridScreenState();
}

class _FoodGridScreenState extends State<FoodGridScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Food Items"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.80,
            ),
            itemBuilder: (context, index) {
              return _foodCard(context, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _foodCard(BuildContext context, int index) {
    final Map<String, dynamic> foodItem = {
      "title": "French fry with Mango juice",
      "description":
      "Crispy golden french fries served with refreshing chilled mango juice. A perfect combo for a quick snack!",
      "price": "\$100",
      "weight": "350g + 250ml",
      "isVeg": true,
      "icon": "assets/icons/foods.png",
    };

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          GestureDetector(
            onTap: () {
              debugPrint('button tapped');
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
              height: 90.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F8),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.r),
                ),
              ),
              child: Center(
                child: Transform.rotate(
                  angle: -0.2,
                  child: Image.asset(
                    foodItem['icon'],
                    scale: 1.6,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodItem['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      foodItem['price'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF00A9B7),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(7.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A9B7),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Image.asset(
                        'assets/icons/buy_icon.png',
                        scale: 7,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}