import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_bite/core/constant/route_names.dart';
import 'package:order_bite/features/buyer/profile/presentation/view/screens/cancel_order_screen.dart';
import 'package:order_bite/features/buyer/profile/presentation/view/screens/order_screen.dart';
import 'package:order_bite/features/buyer/profile/presentation/view/screens/shop_contacts_screen.dart';
import 'package:order_bite/features/buyer/profile/presentation/view/screens/user_info.dart';
import 'package:order_bite/features/seller/profile/presentation/view/screens/graph_chart_screen.dart';
import 'package:order_bite/features/seller/profile/presentation/view/screens/posted_food_item_screen.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  /// IMAGE PICKER FUNCTION
  Future<void> _pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          children: [
            Image.asset(
              'assets/icons/logout_sticker.png',
              scale: 2.5,
            ),
            Text(
              'Logout',
              style: GoogleFonts.merriweather(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to log out of your account?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.loginScreen,
                    (predicate) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  final Map<String, String> userInfo = {
    "Name": "John Doe",
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                /// PROFILE IMAGE
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundColor: Colors.blue.shade100,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage(
                          "assets/images/profile_image.png",
                        ) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: Colors.blue.shade900,
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                SizedBox(height: 16.h),
          
                Align(
                    alignment: Alignment.center,
                    child: Text('pro@gmail.com',style: GoogleFonts.merriweather(fontWeight: FontWeight.w700,fontSize: 14.sp))),
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
                SizedBox(height: 22.h),
          
                _buildCard(
                  context,
                  title: "Posted Items",
                  icon: 'assets/icons/orders_icon.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostedFoodItemScreen(
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
          
                // _buildCard(
                //   context,
                //   title: "Shop Contacts",
                //   icon: 'assets/icons/contact_icon.png',
                //   onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) =>
                //           ShopContactsScreen(shopContacts: shopContacts),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 22.h),
          
                _buildCard(
                  context,
                  title: "Show Graphical View",
                  icon: 'assets/icons/graph.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TopSellingFoodGraphScreen(
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
          
                _buildCard(
                  context,
                  title: "Logout",
                  icon: 'assets/icons/logout.png',
                  onTap: () => showLogoutDialog(context),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required String title,
        required String icon,
        required VoidCallback onTap,
      }) {
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
        contentPadding:
        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
