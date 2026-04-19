import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/category_card.dart';


class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,

          itemCount: 10, // itemCount: লিস্টে মোট কয়টি আইটেম থাকবে।

          itemBuilder: (context, index) => const CategoryCard() , // itemBuilder: প্রতিটি আইটেম দেখতে কেমন হবে।

          separatorBuilder: (context, index) => const SizedBox(width: 6) // separatorBuilder: প্রতিটি আইটেমের মাঝখানে কী থাকবে (যেমন: Divider বা SizedBox)।

      ),
    );
  }
}