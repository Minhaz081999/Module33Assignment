import 'package:crafty_bay/features/product/presentation/screens/product_details_screen.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/wish_list/data/models/wish_list_params.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/controllers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../../product/data/models/product_model.dart';
import '../../../wish_list/presentation/providers/wish_list_provider.dart';

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
    // ProductCard এর build মেথডের ভেতর দিন
    print("Product: ${productModel.title} -> Image URL: ${_getImage(productModel.images)}");
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
                height: 125,
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
                          child: Consumer<WishListProvider>(
                            builder: (context,wishListProvider,_) {
                              return GestureDetector(
                                      onTap: (){
                                        _onTapWishList(context);
                                      },
                                child: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              );
                            }
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
  // for wish list button
Future<void> _onTapWishList(BuildContext context )async{
  // ১. চেক করুন ইউজার লগইন আছে কি না
  if (await AuthController.isLoggedIn() == false) {
    Navigator.pushNamed(context, SignInScreen.name);
    return;
  }

    final params = WishListParams(productId: productModel.id);

    final wishListProvider = context.read<WishListProvider>();

    final isSuccess = await wishListProvider.addToWishList(params);
  // ২. চেক করুন উইজেটটি এখনও স্ক্রিনে আছে কি না (Mounted Check)
  // স্ক্রিনটি এখনো আছে কি না চেক করা
  if (!context.mounted) return;

    if(isSuccess ){
    showSnackBarMessage(context, 'Added to wishlist');
    }else{
      showSnackBarMessage(context, wishListProvider.errorMessage ?? "Failed to add to wish list ");
    }
  }
  // String _getImage(List<String> urls) {
  //   if (urls.isNotEmpty && urls.first.startsWith('http')) {
  //     return urls.first.trim();
  //   }
  //   // এখানে একটি অনলাইন প্লেসহোল্ডার ইমেজের লিঙ্ক দিতে পারেন
  //   return 'https://via.placeholder.com/150';
  // }
}