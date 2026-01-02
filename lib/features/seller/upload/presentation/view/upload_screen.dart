import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constant/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seller Food Upload',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UploadScreen(),
    );
  }
}

/* ---------------- FOOD MODEL ---------------- */

class FoodItem {
  String name;
  String ingredients;
  double price;
  String weight;
  bool isVeg;
  String stallName;
  String availableTime;
  String imagePath;

  FoodItem({
    required this.name,
    required this.ingredients,
    required this.price,
    required this.weight,
    required this.isVeg,
    required this.stallName,
    required this.availableTime,
    required this.imagePath,
  });
}

/* ---------------- ROTATING AVATAR ---------------- */

class RotatingAvatar extends StatefulWidget {
  final String imagePath;
  final double radius;

  const RotatingAvatar({
    super.key,
    required this.imagePath,
    this.radius = 55,
  });

  @override
  State<RotatingAvatar> createState() => _RotatingAvatarState();
}

class _RotatingAvatarState extends State<RotatingAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.6),
              blurRadius: 14,
              spreadRadius: 3,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: widget.radius,
          backgroundImage: FileImage(File(widget.imagePath)),
        ),
      ),
    );
  }
}

/* ---------------- MAIN LIST SCREEN ---------------- */

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final List<FoodItem> foods = [];

  void addFood(FoodItem item) {
    setState(() => foods.add(item));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Food Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddFoodScreen()),
              );

              if (result != null && result is FoodItem) {
                addFood(result);
              }
            },
          ),
        ],
      ),
      body: foods.isEmpty
          ? const Center(child: Text("No food posted yet"))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];

          return Container(

            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                RotatingAvatar(imagePath: food.imagePath),
                const SizedBox(height: 12),
                Text(
                  food.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("Ingredients: ${food.ingredients}"),
                Text("Price: ${food.price} BDT"),
                Text("Weight: ${food.weight}"),
                Text("Stall: ${food.stallName}"),
                Text("Available: ${food.availableTime}"),
                const SizedBox(height: 6),
                Chip(
                  label: Text(food.isVeg ? "Veg" : "Non-Veg"),
                  backgroundColor:
                  food.isVeg ? Colors.green : Colors.red,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/* ---------------- ADD FOOD SCREEN ---------------- */

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ingredientController = TextEditingController();
  final priceController = TextEditingController();
  final weightController = TextEditingController();

  bool isVeg = true;
  String stallName = "Main Stall";
  String availableTime = "10:00 AM - 5:00 PM";
  File? image;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picked =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => image = File(picked.path));
    }
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an image"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      FoodItem(
        name: nameController.text,
        ingredients: ingredientController.text,
        price: double.parse(priceController.text),
        weight: weightController.text,
        isVeg: isVeg,
        stallName: stallName,
        availableTime: availableTime,
        imagePath: image!.path,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Food")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: RotationTransition(
                  turns: _controller,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue.shade50,
                    backgroundImage:
                    image != null ? FileImage(image!) : null,
                    child: image == null
                        ? const Icon(Icons.camera_alt, size: 40)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Food Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: ingredientController,
                decoration: const InputDecoration(labelText: "Ingredients"),
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(labelText: "Weight"),
              ),

              DropdownButtonFormField(
                value: stallName,
                items: const [
                  DropdownMenuItem(
                      value: "Main Stall", child: Text("Main Stall")),
                  DropdownMenuItem(
                      value: "Fast Food", child: Text("Fast Food")),
                ],
                onChanged: (v) => stallName = v!,
                decoration: const InputDecoration(labelText: "Stall"),
              ),

              SwitchListTile(
                title: const Text("Veg"),
                value: isVeg,
                onChanged: (v) => setState(() => isVeg = v),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
                  child: const Text("Post Food"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}