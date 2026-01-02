import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditUserInfoScreen extends StatefulWidget {
  final Map<String, String> userInfo;
  const EditUserInfoScreen({super.key, required this.userInfo});

  @override
  State<EditUserInfoScreen> createState() => _EditUserInfoScreenState();
}

class _EditUserInfoScreenState extends State<EditUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = {
      for (var entry in widget.userInfo.entries)
        entry.key: TextEditingController(text: entry.value)
    };
  }

  @override
  void dispose() {
    for (var c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ...controllers.entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: TextFormField(
                    controller: entry.value,
                    decoration: InputDecoration(
                      labelText: entry.key,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                  ),
                );
              }),

              SizedBox(height: 20.h),

              SizedBox(
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedData = {
                        for (var e in controllers.entries) e.key: e.value.text
                      };
                      Navigator.pop(context, updatedData);
                    }
                  },
                  child: const Text("Save Changes"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}