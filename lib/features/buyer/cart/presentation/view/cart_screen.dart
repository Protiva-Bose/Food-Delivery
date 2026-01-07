import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_bite/features/buyer/cart/presentation/view/screens/food_selected_screen.dart';
import 'package:order_bite/features/buyer/cart/presentation/view/screens/order_confirmation_screen.dart';

class CartScreen extends StatelessWidget {
  final quantity = 1;
  final TextEditingController _searchController = TextEditingController();

  CartScreen({super.key});

  final List<Map<String, dynamic>> stalls = [
    {
      "name": "Pizza Stall",
      "icon": "assets/icons/shop_image.png",
      "foods": [
        {"name": "Margherita", "price": 5.0, "isVeg": true},
        {"name": "Pepperoni", "price": 6.0, "isVeg": false},
      ],
    },
    {
      "name": "Burger Stall",
      "icon": "assets/icons/shop_image.png",
      "foods": [
        {"name": "Veggie Burger", "price": 4.0, "isVeg": true},
        {"name": "Cheese Burger", "price": 5.0, "isVeg": false},
      ],
    },
    {
      "name": "Dessert Stall",
      "icon": "assets/icons/shop_image.png",
      "foods": [
        {"name": "Chocolate Cake", "price": 3.0, "isVeg": true},
        {"name": "Ice Cream", "price": 2.5, "isVeg": true},
      ],
    },
  {
    "name": "Sushi Corner",
    "icon": "assets/icons/shop_image.png",
    "foods": [
      {"name": "California Roll", "price": 7.5, "isVeg": false},
      {"name": "Avocado Maki", "price": 6.0, "isVeg": true},
      {"name": "Spicy Tuna Roll", "price": 8.0, "isVeg": false},
    ],
  },
  {
    "name": "Taco Fiesta",
    "icon": "assets/icons/shop_image.png",
    "foods": [
      {"name": "Veggie Taco", "price": 4.5, "isVeg": true},
      {"name": "Chicken Taco", "price": 5.5, "isVeg": false},
      {"name": "Beef Taco", "price": 6.0, "isVeg": false},
    ],
  },
  {
    "name": "Pasta House",
    "icon": "assets/icons/shop_image.png",
    "foods": [
      {"name": "Spaghetti Marinara", "price": 7.0, "isVeg": true},
      {"name": "Fettuccine Alfredo", "price": 8.5, "isVeg": true},
      {"name": "Chicken Penne", "price": 9.0, "isVeg": false},
    ],
  },
  {
    "name": "Smoothie Bar",
    "icon": "assets/icons/shop_image.png",
    "foods": [
      {"name": "Strawberry Banana", "price": 4.0, "isVeg": true},
      {"name": "Mango Pineapple", "price": 4.5, "isVeg": true},
      {"name": "Green Detox", "price": 5.0, "isVeg": true},
    ],
  },
  {
    "name": "Grill Station",
    "icon": "assets/icons/shop_image.png",
    "foods": [
      {"name": "Grilled Veg Sandwich", "price": 5.0, "isVeg": true},
      {"name": "Grilled Chicken Sandwich", "price": 6.5, "isVeg": false},
      {"name": "Grilled Steak", "price": 10.0, "isVeg": false},
    ],
  },
];


  void showFoodDialog(BuildContext context, Map<String, dynamic> stall) async {
    final selectedFoods = await showDialog<List<Map<String, dynamic>>>(
      context: context,
      builder: (_) => FoodSelectionDialog(stall: stall, userName: '', userId: '',),
    );

    if (selectedFoods != null && selectedFoods.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrderConfirmationScreen(
            stallName: "Burger Stall",
            selectedFoods: [
              {
                "name": "Chicken Burger",
                "price": 80.0,
                "weight": "120g",
                "isVeg": false,
                "quantity": quantity,
              }
            ],
            userName: "John Doe",
            userId: "12345",
          ),
        ),
      );

    }
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(title: Text("Select a Stall",style: GoogleFonts.merriweather(
        fontWeight: FontWeight.w600,fontSize: 18.sp,
      ),),
      leading: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset('assets/icons/stall.png',scale: 3,),
      ),),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: _border(),
                  enabledBorder: _border(),
                  focusedBorder: _border(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: stalls.length,
                  itemBuilder: (context, index) {
                    final stall = stalls[index];
                    return GestureDetector(
                      onTap: () => showFoodDialog(context, stall),
                      child: SizedBox(
                        height: 80.h,
                        child: Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.asset(stall['icon'], width: 50.w, height: 50.h),
                              title: Text(stall['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}