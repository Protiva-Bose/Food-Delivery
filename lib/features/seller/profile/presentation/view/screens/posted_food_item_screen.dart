import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PostedFoodItemScreen extends StatelessWidget {
  const PostedFoodItemScreen({super.key});

  final List<Map<String, dynamic>> foodList = const [
    {
      "date": "Today",
      "items": [
        {
          "name": "Veg Burger",
          "price": 120,
          "image": "assets/icons/foods.png",
          "type": "veg",
        },
        {
          "name": "Chicken Pizza",
          "price": 250,
          "image": "assets/icons/foods.png",
          "type": "non-veg",
        },
      ]
    },
    {
      "date": "Yesterday",
      "items": [
        {
          "name": "Paneer Roll",
          "price": 150,
          "image": "assets/icons/foods.png",
          "type": "veg",
        },
      ]
    },
    {
      "date": "12 Jan 2026",
      "items": [
        {
          "name": "Beef Biryani",
          "price": 300,
          "image": "assets/icons/foods.png",
          "type": "non-veg",
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new)),
        backgroundColor: Colors.blue.shade50,
        title:  Text("My Food Posts",style: GoogleFonts.merriweather(),),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          final section = foodList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  section["date"],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ...section["items"].map<Widget>((item) {
                return _foodCard(item);
              }).toList(),
            ],
          );
        },
      ),
    );
  }

  Widget _foodCard(Map<String, dynamic> food) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: Colors.blue.shade700,
            width: 5,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                food["image"],
                height: 70.h,
                width: 70.h,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food["name"],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "৳ ${food["price"]}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: food["type"] == "veg"
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: food["type"] == "veg"
                        ? Colors.green
                        : Colors.red,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    food["type"] == "veg" ? "Veg" : "Non-Veg",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
