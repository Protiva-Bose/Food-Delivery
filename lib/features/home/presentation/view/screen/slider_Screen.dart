import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../core/constant/app_colors.dart';

class CarouselExample extends StatefulWidget {
  const CarouselExample({super.key});

  @override
  State<CarouselExample> createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {
  final List<Map<String, String>> slides = [
    {
      "image": "assets/icons/pizza.png",
      "title": "Fresh bites\ninstant delight",
      "subtitle": "“Fast, fresh, and\nirresistibly delicious.”",
    },
    {
      "image": "assets/icons/drinks.png",
      "title": "Cool Drinks\nRefreshing\ntaste",
      "subtitle": "“Chilled, tasty, and\npure refreshment.”",
    },
    {
      "image": "assets/icons/snacks_icon.png",
      "title": "Tasty Snacks\nQuick bites",
      "subtitle": "“Crunchy, fresh, and\nso delightful.”",
    },
    {
      "image": "assets/icons/fast_food.png",
      "title": "Fast Food\nHot & Delicious",
      "subtitle": "“Quick, yummy, and\nsatisfying.”",
    },
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Carousel Slider
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: slides.map((slide) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(slide["image"]!, scale: 1.9),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              slide["title"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              slide["subtitle"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(slides.length, (index) {
            bool isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 20,
              height: 6,
              decoration: BoxDecoration(
                gradient: isActive
                    ? AppColors.primaryGradient
                    : LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade200]),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),

      ],
    );
  }
}
