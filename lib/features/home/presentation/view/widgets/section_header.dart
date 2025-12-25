import 'package:flutter/material.dart';

import '../../../../../core/constant/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            'See All',
            style: TextStyle(
              color: Color(0xFF00A9B7),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}


