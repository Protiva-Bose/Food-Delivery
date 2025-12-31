import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final Color Function(String) getStatusColor;

  const OrdersScreen({super.key, required this.orders, required this.getStatusColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: ListView(
        padding: EdgeInsets.all(12.w),
        children: orders.map((order) {
          return Column(
            children: [
              SizedBox(height: 15.h,),
              Container(
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
                  title: Text(order['item']),
                  subtitle: Text(order['stall']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(order['status'],
                          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: getStatusColor(order['status']))),
                      if (order['status'] == "Pending")
                        IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {

                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}