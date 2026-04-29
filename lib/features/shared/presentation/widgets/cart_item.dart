import 'package:crafty_bay/features/cart/data/models/cart_model.dart';
import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';
import 'inc_dec_button.dart';

//
// class CartItem extends StatelessWidget {
//   const CartItem({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: .zero,
//       child: Row(
//         spacing: 6,
//         children: [
//           // -------- Image --------
//           Image.asset(AssetPaths.dummyShoePng, width: 100,),
//           // -------- Text, Icon, Button --------------
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//
//                 mainAxisAlignment: .start,
//                 children: [
//                   // ----- Text, Icon -------
//                   Row(
//                     crossAxisAlignment: .start,
//                     mainAxisAlignment: .spaceBetween,
//                     children: [
//                       // Text
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: .start,
//                           children: [
//                             Text(
//                               'Nike New Shoe DF3434k 2026 Edition',
//                               maxLines: 1,
//                               overflow: .ellipsis,
//                               style: context.textTheme.bodyLarge?.copyWith(
//                                   fontWeight: .w600
//                               ),
//                             ),
//                             Text('Color: Red Size: XL'),
//                           ],
//                         ),
//                       ),
//                       // Icon
//                       IconButton(
//                           onPressed: (){},
//                           icon: Icon(Icons.delete, color: Colors.grey,)
//                       )
//                     ],
//                   ),
//                   // ------ Text, Button -------
//                   Row(
//                     mainAxisAlignment: .spaceBetween,
//                     children: [
//                       // Text
//                       Text('${Constants.takaSign}120',style: context.textTheme.bodyLarge?.copyWith(
//                           fontWeight: .bold,
//                           color: AppColors.themeColor
//                       ),
//                       ),
//                       // Button
//                       IncDecButton(
//                         initialValue: 5,
//                         onChange: (int newValue) {
//                           print(newValue);
//                         },)
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
// }
class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartModel });

  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.themeColor.withAlpha(20),
      margin: .symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          AppNetworkImage(
            url: _getImage(cartModel.productModel.images),
            width: 100,
            height: 80,
            fit: .scaleDown,
          ),
          Expanded(
            child: Padding(
              padding: const .all(8),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              // 'Nike New Shoe DF3434K 2026 Edition',
                              cartModel.productModel.title,
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text('Color: ${cartModel.color ?? 'N/A'} Size: ${cartModel.size ?? 'N/A'}' ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: ()  {
                          // TODO : delete from api and update into provider
                          DeleteCartItem(context);
                        },
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        '${Constants.takaSign}${cartModel.productModel.currentPrice}',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.themeColor,
                          fontWeight: .bold,
                        ),
                      ),
                      IncDecButton(
                        initialValue: cartModel.quantity,
                        maxValue: 5,
                        onChange: (int value) {
                          print(value);
                          context.read<CartListProvider>()
                          .updateCartItemQuantity(cartModel.id, value);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  String _getImage(List<String> urls) {
    return urls.isNotEmpty ? urls.first : '';
  }
  // FOR delete cart item ------------------------

Future<void> DeleteCartItem(BuildContext context) async{
  final cartListProvider = context.read<CartListProvider>();
  bool result = await cartListProvider.deleteCartItem(cartModel.id);

  if (result ) {
    if (context.mounted) {
      showSnackBarMessage(context, 'Item removed from cart!');
    }
  } else {
    if (context.mounted) {
      showSnackBarMessage(context, cartListProvider.errorMessage ?? 'Delete failed'
      );
    }
  }
}
}