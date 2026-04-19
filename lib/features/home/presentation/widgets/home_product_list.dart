import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/product_card.dart';


class HomeProductList extends StatelessWidget {
  const HomeProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,

          itemCount: 10, // itemCount: লিস্টে মোট কয়টি আইটেম থাকবে।

          itemBuilder: (context, index) => const ProductCard(), // itemBuilder: প্রতিটি আইটেম দেখতে কেমন হবে।

          separatorBuilder: (context, index) => const SizedBox(width: 6) // separatorBuilder: প্রতিটি আইটেমের মাঝখানে কী থাকবে (যেমন: Divider বা SizedBox)।

      ),
    );
  }
}
