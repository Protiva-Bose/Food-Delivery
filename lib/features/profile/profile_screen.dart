import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_bite/features/profile/view/cancel_order_screen.dart';
import 'package:order_bite/features/profile/view/order_screen.dart';
import 'package:order_bite/features/profile/view/shop_contacts_screen.dart';
import 'package:order_bite/features/profile/view/user_info.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final Map<String, String> userInfo = {
    "Name": "John Doe",
    "Email": "johndoe@example.com",
    "Phone": "+1234567890",
    "College": "ABC",
    "Department": "Science",
    "Group/Section": "B",
    "Roll": "41",
  };

  final List<Map<String, dynamic>> orders = [
    {"item": "Margherita Pizza", "stall": "Pizza Stall", "status": "Confirmed"},
    {"item": "Veggie Burger", "stall": "Burger Stall", "status": "Pending"},
    {"item": "Chocolate Cake", "stall": "Dessert Stall", "status": "Cancelled"},
  ];

  final List<Map<String, String>> shopContacts = [
    {"name": "Pizza Stall", "phone": "+111111111"},
    {"name": "Burger Stall", "phone": "+222222222"},
    {"name": "Dessert Stall", "phone": "+333333333"},
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
          Center(
          child: Stack(
          children: [
            CircleAvatar(
            radius: 60.r,
            backgroundColor: Colors.blue.shade100,
            backgroundImage: AssetImage("assets/images/profile_image.png"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {

              },
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: Colors.blue.shade900,
                child: const Icon(Icons.edit, color: Colors.white, size: 20),
              ),
            ),
          ),
          ],
        ),
      ),

        SizedBox(height: 16.h),

              _buildCard(
                context,
                title: "User Information",
                icon: 'assets/icons/user_icon.png',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserInfoScreen(userInfo: userInfo),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              _buildCard(
                context,
                title: "My Orders",
                icon: 'assets/icons/orders_icon.png',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrdersScreen(
                      orders: orders,
                      getStatusColor: getStatusColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              _buildCard(
                context,
                title: "Shop Contacts",
                icon: 'assets/icons/contact_icon.png',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShopContactsScreen(shopContacts: shopContacts),
                  ),
                ),
              ),SizedBox(height: 12.h),

              _buildCard(
                context,
                title: "Cancel Orders",
                icon: 'assets/icons/cancel_icon.png',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CancelOrderScreen(orders: orders,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required String icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: Colors.blue.shade600,
            width: 4.w,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        leading: Image.asset(icon, scale: 4),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}