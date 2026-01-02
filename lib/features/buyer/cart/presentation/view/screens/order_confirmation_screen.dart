import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../parent/presentation/view/parent_screen.dart';
import 'congratulations_screen.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String stallName;
  final List<Map<String, dynamic>> selectedFoods;

  const OrderConfirmationScreen({super.key, required this.stallName, required this.selectedFoods});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final Map<int, int> quantities = {};
  String note = "";
  String orderType = "Instant Plate";

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.selectedFoods.length; i++) {
      quantities[i] = 1;
    }
  }

  double get totalPrice {
    double sum = 0;
    for (int i = 0; i < widget.selectedFoods.length; i++) {
      sum += (widget.selectedFoods[i]['price'] as double) * quantities[i]!;
    }
    return sum;
  }

  void incrementQuantity(int index) {
    setState(() {
      quantities[index] = quantities[index]! + 1;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (quantities[index]! > 1) {
        quantities[index] = quantities[index]! - 1;
      }
    });
  }

  void showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        icon: LottieScreen(),
        title: const Text("Congratulations!"),
        content: const Text("Your order has been successfully placed."),
        actions: [
          Center(
            child: SizedBox(
              width: 100.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900
                ),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ParentScreen())),
                child: const Text("OK"),
                      ),
            ),
          ),
       ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(title: const Text("Confirm Your Order"),
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stall: ${widget.stallName}",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              Text(
                "Selected Items:",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.selectedFoods.length,
                  itemBuilder: (_, index) {
                    final food = widget.selectedFoods[index];
                    final qty = quantities[index]!;
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: food['isVeg'] ? Colors.green : Colors.red,
                              child: Text(food['isVeg'] ? "V" : "N", style: const TextStyle(color: Colors.white)),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(food['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text("\$${food['price']}"),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => decrementQuantity(index),
                                ),
                                Text(qty.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => incrementQuantity(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(
                  labelText: "Add a note (optional)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                onChanged: (val) => note = val,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      activeColor: Colors.blue.shade900,
                      title: const Text("Instant Plate"),
                      value: "Instant Plate",
                      groupValue: orderType,
                      onChanged: (val) => setState(() => orderType = val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Parcel"),
                      value: "Parcel",
                      groupValue: orderType,
                      onChanged: (val) => setState(() => orderType = val!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  Text("\$${totalPrice.toStringAsFixed(2)}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900
                  ),
                  onPressed: showCongratulationsDialog,
                  child:  Text("Done",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}