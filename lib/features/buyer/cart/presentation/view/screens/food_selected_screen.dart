import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_confirmation_screen.dart'; // Import the order confirmation screen

class FoodSelectionDialog extends StatefulWidget {
  final Map<String, dynamic> stall;
  final String userName;
  final String userId;

  const FoodSelectionDialog({
    super.key,
    required this.stall,
    required this.userName,
    required this.userId,
  });

  @override
  State<FoodSelectionDialog> createState() => _FoodSelectionDialogState();
}

class _FoodSelectionDialogState extends State<FoodSelectionDialog> {
  final List<Map<String, dynamic>> selectedFoods = [];

  void toggleSelection(Map<String, dynamic> food) {
    setState(() {
      if (selectedFoods.contains(food)) {
        selectedFoods.remove(food);
      } else {
        selectedFoods.add(food);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final foods = widget.stall['foods'] as List<Map<String, dynamic>>;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text("Select Foods from ${widget.stall['name']}"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: foods.length,
          itemBuilder: (_, index) {
            final food = foods[index];
            final isSelected = selectedFoods.contains(food);
            return ListTile(
              onTap: () => toggleSelection(food),
              leading: CircleAvatar(
                backgroundColor: food['isVeg'] ? Colors.green : Colors.red,
                child: Text(food['isVeg'] ? "V" : "N",
                    style: const TextStyle(color: Colors.white)),
              ),
              title: Text(food['name']),
              subtitle: Text("\$${food['price']}"),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.blue)
                  : const Icon(Icons.circle_outlined),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
          onPressed: selectedFoods.isEmpty
              ? null
              : () {
            // Pass selected foods to OrderConfirmationScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderConfirmationScreen(
                  stallName: widget.stall['name'],
                  selectedFoods: selectedFoods,
                  userName: widget.userName,
                  userId: widget.userId,
                ),
              ),
            );
          },
          child: const Text("Next"),
        ),
      ],
    );
  }
}
