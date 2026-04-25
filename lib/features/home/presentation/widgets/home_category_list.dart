import 'package:crafty_bay/features/shared/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/category_card.dart';




class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _ ) {
          if(categoryListProvider.getInitialDataInProgress){
            return CenterProgressIndicator();
          }

          return ListView.separated(
              scrollDirection: Axis.horizontal,

              itemCount: getCategoryLength(categoryListProvider.categoryList.length), // itemCount: লিস্টে মোট কয়টি আইটেম থাকবে।

              itemBuilder: (context, index) {
                return  CategoryCard(categoryModel: categoryListProvider.categoryList[index] );
                // , // itemBuilder: প্রতিটি আইটেম দেখতে কেমন হবে।
              },
              separatorBuilder: (context, index) => const SizedBox(width: 6) // separatorBuilder: প্রতিটি আইটেমের মাঝখানে কী থাকবে (যেমন: Divider বা SizedBox)।

          );
        }
      ),
    );
  }

  // create USER define function()
  int getCategoryLength(length){
    return (length > 10) ? 10 : length ;
  }

}