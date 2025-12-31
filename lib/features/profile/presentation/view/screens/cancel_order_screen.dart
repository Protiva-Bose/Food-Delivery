import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelOrderScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  const CancelOrderScreen({super.key, required this.orders});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  late List<Map<String, dynamic>> confirmedOrders;

  @override
  void initState() {
    super.initState();
    confirmedOrders =
        widget.orders.where((order) => order['status'] == "Confirmed").toList();
  }

  void cancelOrder(int index) {
    setState(() {
      confirmedOrders.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Order cancelled successfully"),
        backgroundColor: Colors.green,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cancel Orders")),
      body: confirmedOrders.isEmpty
          ? Center(
        child: Text(
          "No confirmed orders",
          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: confirmedOrders.length,
        itemBuilder: (context, index) {
          final order = confirmedOrders[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            margin: EdgeInsets.only(bottom: 12.h),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: AssetImage(
                            order['image'] ?? "assets/icons/shop_image.png"),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order['item'],
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(order['stall'],
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey[700])),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  Text("Price: \$${order['price']}"),
                  Text("Quantity: ${order['quantity'] ?? 1}"),
                  Text("Status: ${order['status']}"),
                  SizedBox(height: 12.h),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => cancelOrder(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: const Text("Cancel Order"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}