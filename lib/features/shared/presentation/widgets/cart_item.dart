import 'package:flutter/material.dart';

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
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.themeColor.withAlpha(20),
      margin: .symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          Image.asset(AssetPaths.dummyShoePng, width: 100),
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
                              'Nike New Shoe DF3434K 2026 Edition',
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text('Color: Red  Size: XL'),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
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
                        '${Constants.takaSign}120',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.themeColor,
                          fontWeight: .bold,
                        ),
                      ),
                      IncDecButton(
                        initialValue: 1,
                        maxValue: 5,
                        onChange: (int value) {
                          print(value);
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
}