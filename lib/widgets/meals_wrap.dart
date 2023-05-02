import 'package:flutter/material.dart';

import '../features/restaurant/data/models/category.dart';

class MealsWrap extends StatelessWidget {
  const MealsWrap({
    super.key,
    required this.title,
    required this.categories,
  });

  final String title;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Wrap(
          spacing: 16,
          children:
              categories.map((e) => Chip(label: Text(e.name ?? '-'))).toList(),
        ),
      ],
    );
  }
}
