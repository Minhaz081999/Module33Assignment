import 'package:crafty_bay/features/product/presentation/screens/product_details_screen.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../product/data/models/product_model.dart';

//
// class ProductCard extends StatelessWidget {
//   const ProductCard({
//     super.key, required this.productModel,
//   });
//
//   final ProductModel productModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Navigator.pushNamed(context, ProductDetailsScreen.name);
//       },
//       child: SizedBox(
//         width: 180,
//         child: Card(
//           // shadow
//           elevation: 3,
//           shadowColor: AppColors.themeColor.withAlpha(30),
//           color: Colors.white,
//           shape:RoundedRectangleBorder(
//               borderRadius: .circular(10),
//               side: BorderSide(width: 0, style: .solid)
//           ),
//           child: Column(
//             children: [
//               // ----- Image -----
//               // 45:43 minutes
//               Container(
//                 width: 180,
//                 height: 140,
//                 padding: .all(16),
//                 decoration: BoxDecoration(
//                     color: AppColors.themeColor.withAlpha(20),
//                     borderRadius: .circular(10),
//                   border: Border.all(width: 0,style: .solid)
//                 ),
//                 // child: Image.asset(AssetPaths.dummyShoePng,),
//                 child: AppNetworkImage(url: _getImage(productModel.images) ),
//               ),
//               // ------ Text -----
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text(productModel.title,
//                       maxLines: 1,
//                       style: TextStyle(
//                           fontWeight: .w500,
//                           color: Colors.black54,
//                           overflow: .ellipsis
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: .spaceBetween,
//                       children: [
//                         Text('${Constants.takaSign}${productModel.currentPrice}',style: TextStyle(
//                             fontWeight: .w500,
//                             color: AppColors.themeColor
//                         ),),
//                         Wrap(
//                           children: [
//                             Icon(Icons.star, size: 16, color: Colors.amber,),
//                             Text('${productModel.rating}'),
//                           ],
//                         ),
//                         Container(
//                           padding: .all(4),
//                           decoration: BoxDecoration(
//                               color: AppColors.themeColor,
//                               borderRadius: .circular(8)
//                           ),
//                           child: Icon(Icons.favorite_outline, size: 16, color: Colors.white,),
//                         ),
//                       ],
//                     ),
//
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _getImage(List<String> urls) {
//     return urls.isNotEmpty ? urls.first : '';
//   }
// }
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.name,
          arguments: productModel.id,
        );
      },
      child: SizedBox(
        width: 180,
        child: Card(
          elevation: 2,
          shadowColor: AppColors.themeColor.withAlpha(30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: 180,
                height: 140,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha(20),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: AppNetworkImage(url: _getImage(productModel.images)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productModel.title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${Constants.takaSign}${productModel.currentPrice}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            Text('${productModel.rating}'),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  String _getImage(List<String> urls) {
    return urls.isNotEmpty ? urls.first : '';
  }
}