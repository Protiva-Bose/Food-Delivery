import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopContactsScreen extends StatelessWidget {
  final List<Map<String, String>> shopContacts;
  const ShopContactsScreen({super.key, required this.shopContacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text("Shop Contacts",style: GoogleFonts.merriweather(
          fontWeight: FontWeight.w600,fontSize: 18.sp,
        ),),leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),),
      body: ListView(
        padding: EdgeInsets.all(12.w),
        children: shopContacts.map((shop) {
          return Column(
            children: [
              SizedBox(height: 15.h,),
              Container(  decoration: BoxDecoration(
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
                  title: Text(shop['name']!),
                  trailing: Text(shop['phone']!),
                  onTap: () {

                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}