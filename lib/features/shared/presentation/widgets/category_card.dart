import 'package:crafty_bay/features/product/presentation/screens/product_list_screen.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         Navigator.pushNamed(context, ProductListScreen.name,arguments: 'Electronics');
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
              child: Icon(
                Icons.laptop, size: 48, color: AppColors.themeColor,),
            ),
          ),
          // ------ Text --------
          Text(getTitle('Electronics'), style:context.textTheme.bodyLarge?.copyWith(
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