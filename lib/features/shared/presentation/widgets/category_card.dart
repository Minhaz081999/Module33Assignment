import 'package:crafty_bay/features/product/presentation/screens/product_list_screen.dart';
import 'package:crafty_bay/features/shared/data/models/category_model.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';
import 'package:flutter/material.dart';


import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key, required this.categoryModel
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         Navigator.pushNamed(context, ProductListScreen.name,arguments: categoryModel );
      },
      child: Column(
        spacing: 4,
        children: [
          // ------ Icon --------
          Card(
            // background color
            color: AppColors.themeColor.withAlpha(20),
            elevation: 0, // shadow
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppNetworkImage(url: categoryModel.icon, height: 48, width: 48,)
            ),
          ),
          // ------ Text --------
          Text(getTitle(categoryModel.title ), style:context.textTheme.bodyLarge?.copyWith(
              color: AppColors.themeColor,
              fontWeight: .bold
          )
          ),
        ],
      ),
    );
  }

  String getTitle(String name){
    if(name.length > 10){
      return '${name.substring(0,10)}...';
    }else{
      return name;
    }
  }
}