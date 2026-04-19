import 'package:crafty_bay/features/product/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductDetailsScreen.name);
      },
      child: SizedBox(
        width: 180,
        child: Card(
          // shadow
          elevation: 3,
          shadowColor: AppColors.themeColor.withAlpha(30),
          color: Colors.white,
          shape:RoundedRectangleBorder(
              borderRadius: .circular(10),
              side: BorderSide(width: 0, style: .solid)
          ),
          child: Column(
            children: [
              // ----- Image -----
              // 45:43 minutes
              Container(
                width: 180,
                height: 140,
                padding: .all(16),
                decoration: BoxDecoration(
                    color: AppColors.themeColor.withAlpha(20),
                    borderRadius: .circular(10),
                  border: Border.all(width: 0,style: .solid)
                ),
                child: Image.asset(AssetPaths.dummyShoePng,),
              ),
              // ------ Text -----
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Nike A34RF - New edition 2026 Alpha',
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: .w500,
                          color: Colors.black54,
                          overflow: .ellipsis
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('${Constants.takaSign}120',style: TextStyle(
                            fontWeight: .w500,
                            color: AppColors.themeColor
                        ),),
                        Wrap(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber,),
                            Text('4.5'),
                          ],
                        ),
                        Container(
                          padding: .all(4),
                          decoration: BoxDecoration(
                              color: AppColors.themeColor,
                              borderRadius: .circular(8)
                          ),
                          child: Icon(Icons.favorite_outline, size: 16, color: Colors.white,),
                        ),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}