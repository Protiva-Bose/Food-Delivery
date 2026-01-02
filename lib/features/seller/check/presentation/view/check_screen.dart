import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Order {
  final String customerName;
  final String customerNumber;
  final String foodName;
  final String foodImage;
  final int quantity;
  final double price;
  final String orderType;
  final String pickupTime;

  String? orderId;
  bool isAccepted;

  Order({
    required this.customerName,
    required this.customerNumber,
    required this.foodName,
    required this.foodImage,
    required this.quantity,
    required this.price,
    required this.orderType,
    required this.pickupTime,
    this.orderId,
    this.isAccepted = false,
  });
}

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final List<Order> pendingOrders = [
    Order(
      customerName: "John Doe",
      customerNumber: "017XXXXXXXX",
      foodName: "Burger",
      foodImage:
      "assets/icons/food_item.png",
      quantity: 2,
      price: 500,
      orderType: "Parcel",
      pickupTime: "12:30 PM",
    ),
    Order(
      customerName: "Jane Smith",
      customerNumber: "018XXXXXXXX",
      foodName: "Pizza",
      foodImage:
      "assets/icons/food_item.png",
      quantity: 1,
      price: 800,
      orderType: "Instant",
      pickupTime: "12:45 PM",
    ),
  ];

  void acceptOrder(Order order) async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Enter Order ID"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Ex: ORD-1023",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;

              setState(() {
                order.isAccepted = true;
                order.orderId = controller.text.trim();
              });

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Order ID ${order.orderId} sent to ${order.customerName}",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  void cancelOrder(Order order) {
    setState(() {
      pendingOrders.remove(order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Orders",style: GoogleFonts.merriweather(),),
        backgroundColor: Colors.white70,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pendingOrders.length,
        itemBuilder: (context, index) {
          final order = pendingOrders[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h,),
                      Text(
                        "Customer: ${order.customerName}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text("Phone: ${order.customerNumber}"),
                      const SizedBox(height: 8),
                      Text(
                          "Food: ${order.foodName} x${order.quantity}"),
                      Text("Price: ${order.price} BDT"),
                      Text("Order Type: ${order.orderType}"),
                      Text("Pickup Time: ${order.pickupTime}"),

                      if (order.orderId != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Order ID: ${order.orderId}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (!order.isAccepted) ...[
                            ElevatedButton(
                              onPressed: () => acceptOrder(order),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: const Text("Accept"),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => cancelOrder(order),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text("Cancel"),
                            ),
                          ] else
                            const Text(
                              "Order Accepted",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: order.isAccepted ? 0 : 1,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 500),
                    scale: order.isAccepted ? 0 : 1,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 0.1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.blue.shade50,
                        backgroundImage: AssetImage(order.foodImage),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}