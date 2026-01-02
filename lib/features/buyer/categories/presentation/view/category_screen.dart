import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../home/presentation/view/widgets/category_item.dart';

class CategoryGrid extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> categories = List.generate(
    12,
        (index) => {
      "title": "Category ${index + 1}",
      "icon": "assets/icons/chicken_icon.png",
      "description": '''🍤 Prawn Fry Description
Prawn Fry is a flavorful seafood dish made with fresh, tender prawns that are marinated in aromatic spices and shallow-fried to perfection. The prawns are crispy on the outside and juicy on the inside, offering a rich blend of spicy, savory, and mildly tangy flavors. It is commonly served as a starter or side dish and pairs perfectly with rice, flatbreads, or as a snack.

Ingredients:
Fresh prawns (cleaned and deveined), Vegetable oil, Onion (finely sliced), Garlic, Ginger, Green chilies, Turmeric powder, Red chili powder, Black pepper, Salt (to taste), Lemon juice, Curry leaves
Optional spices: garam masala, coriander powder ''',
      "price": "\$${(index + 1) * 2 + 5}",
      "weight": "${(index + 1) * 50}g",
      "isVeg": index % 2 == 0,
    },
  );

  CategoryGrid({super.key});

  void showFoodDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(16.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(top: 70.h, left: 16.w, right: 16.w, bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    item['title'],
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    item['description'],
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price: ${item['price']}", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Weight: ${item['weight']}", style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: item['isVeg'] ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          item['isVeg'] ? "Veg" : "Non-Veg",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),

            Positioned(
              top: -60.h,
              left: 0,
              right: 0,
              child: Hero(
                tag: item['icon'],
                child: Container(
                  width: 160.w,
                  height: 160.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 3.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 30.r,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      item['icon'],
                      width: 30.w,
                      height: 30.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all( 15.0),
          child: Image.asset('assets/icons/food_details_icon.png',scale: 3,),
        ),
        title: Text('Food Categories with Details',style:  GoogleFonts.merriweather(),),
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: _border(),
                    enabledBorder: _border(),
                    focusedBorder: _border(),
                  ),
                ),
                SizedBox(height: 20.h,),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    return GestureDetector(
                      onTap: () => showFoodDialog(context, item),
                      child: Hero(
                        tag: item['icon'],
                        child: Material(
                          color: Colors.transparent,
                          child: CategoryItem(
                            title: item['title'],
                            iconPath: item['icon'],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}