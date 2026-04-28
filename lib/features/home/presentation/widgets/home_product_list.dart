import 'package:crafty_bay/features/product/presentation/providers/productListProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/center_progress_indicator.dart';
import '../../../shared/presentation/widgets/product_card.dart';


class HomeProductList extends StatelessWidget {
  const HomeProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Consumer<ProductListProvider>(
        builder: (context, productListProvider, _) {
          if(productListProvider.getInitialDataInProgress){
            return CenterProgressIndicator();
          }
          return ListView.separated(
              scrollDirection: Axis.horizontal,

              itemCount: getProductLength(productListProvider.productList.length ), // itemCount: লিস্টে মোট কয়টি আইটেম থাকবে।

              itemBuilder: (context, index)  {
              //  const ProductCard()
                return ProductCard(productModel: productListProvider.productList[index] );

              }, // itemBuilder: প্রতিটি আইটেম দেখতে কেমন হবে।

              separatorBuilder: (context, index) => const SizedBox(width: 6) // separatorBuilder: প্রতিটি আইটেমের মাঝখানে কী থাকবে (যেমন: Divider বা SizedBox)।

          );
        }
      ),
    );
  }
  // create USER define function()
  int getProductLength(length){
    return (length > 10) ? 10 : length ;
  }
}
