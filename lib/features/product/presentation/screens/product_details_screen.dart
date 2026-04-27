import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/product/presentation/widgets/price_and_cart_section.dart';
import 'package:crafty_bay/features/product/presentation/widgets/product_image_carousel.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/controllers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../../shared/presentation/widgets/center_progress_indicator.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/add_to_cart_params.dart';
import '../providers/add_to_cart_provider.dart';
import '../providers/product_details_provider.dart';
import '../widgets/color_picker.dart';
import '../widgets/size_picker.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   const ProductDetailsScreen({super.key});
//
//   static const String name = '/product-details';
//
//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//
//   final ProductDetailsProvider _productDetailsProvider = ProductDetailsProvider();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Product Details')),
//
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // ----- Carousel Slider -------
//                   ProductImageCarousel(),
//                   // ------ Text,Text, Button, Color Picker, Size Picker ---------
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//
//                     child: Column(
//                       crossAxisAlignment: .start,
//                       children: [
//                         const SizedBox(height: 16),
//                         // Text,Button
//                         Row(
//                           crossAxisAlignment: .start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: .start,
//                                 mainAxisAlignment: .start,
//                                 children: [
//                                   Text(
//                                     'NIKE New Shoe DF3434K 2026 Edition',
//                                     style: context.textTheme.bodyLarge
//                                         ?.copyWith(fontWeight: .w600),
//                                   ),
//                                   Row(
//                                     spacing: 8,
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           Icon(
//                                             Icons.star,
//                                             size: 16,
//                                             color: Colors.amber,
//                                           ),
//                                           Text('4.5'),
//                                         ],
//                                       ),
//                                       TextButton(
//                                         onPressed: () {},
//                                         child: Text('Reviews'),
//                                       ),
//                                       Container(
//                                         padding: .all(4),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.themeColor,
//                                           borderRadius: .circular(8),
//                                         ),
//                                         child: Icon(
//                                           Icons.favorite_outline,
//                                           size: 16,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Button
//                             IncDecButton(
//                               onChange: (newValue) {
//                                 print('$newValue');
//                               },
//                             ),
//                           ],
//                         ),
//                         // ------ Colors Picker -----------
//                         ColorPicker(
//                           initialValue: 'red',
//                           colors: ['red', 'green', 'blue', 'yellow', 'orange'],
//                           onSelected: (String selectedColor) {
//                             print(selectedColor);
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         //-------- Sizes Picker --------
//                         SizePicker(
//                           initialValue: 'red',
//                           sizes: ['s', 'm', 'l', 'xl', 'xxl'],
//                           onSelected: (String selectedSize) {
//                             print(selectedSize);
//                           },
//                         ),
//                         const SizedBox(height: 16,),
//                         Text('Description',style: context.textTheme.bodyLarge
//                             ?.copyWith(fontWeight: .w600),),
//                         const SizedBox(height: 8,),
//                         Text('''Dummy description about shoes. ''',style: TextStyle(color: Colors.black54),),
//                         const SizedBox(height: 16,)
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // ------ Text, Button -------
//           PriceAndCartSection(),
//         ],
//       ),
//     );
//   }
// }
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final AddToCartProvider _addToCartProvider = AddToCartProvider();
  final ProductDetailsProvider _productDetailsProvider = ProductDetailsProvider();

  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productDetailsProvider.getProductDetails(
        widget.productId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => _addToCartProvider),
          ChangeNotifierProvider(create: (_) => _productDetailsProvider),
        ],
        child: Consumer<ProductDetailsProvider>(
          builder: (context, provider, _) {
            if (provider.getProductDetailsInProgress) {
              return const CenterProgressIndicator();
            }

            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            }

            if (provider.productDetails == null) {
              return const Center(child: Text('Product details not found'));
            }

            final details = provider.productDetails!;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageCarousel(images: details.photos),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.productDetails!.title,
                                          style: context.textTheme.bodyLarge,
                                        ),
                                        Row(
                                          children: [
                                            Wrap(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.amber,
                                                ),
                                                Text('4.5'),
                                              ],
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text('Reviews'),
                                            ),
                                            Container(
                                              padding: .all(4),
                                              decoration: BoxDecoration(
                                                color: AppColors.themeColor,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Icon(
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
                                  IncDecButton(
                                    maxValue: details.quantity,
                                    onChange: (int value) {
                                      _quantity = value;
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ColorPicker(
                                colors: details.colors,
                                onSelected: (String selectedColor) {
                                  _selectedColor = selectedColor;
                                },
                              ),
                              const SizedBox(height: 16),
                              SizePicker(
                                sizes: details.sizes,
                                onSelected: (String selectedSize) {
                                  _selectedSize = selectedSize;
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Description',
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: .bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                details.description,
                                style: TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PriceAndCartSection(
                  price: details.currentPrice,
                  onTapAddToCart: _onTapAddToCart,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
// User define function()---------------
  Future<void> _onTapAddToCart() async {
    // first check local memory data
    if (await AuthController.isLoggedIn() == false) {
      Navigator.pushNamed(context, SignInScreen.name);
      return;
    }

    AddToCartParams params = AddToCartParams(
      productId: widget.productId,
      color: _selectedColor,
      size: _selectedSize,
      quantity: _quantity,
    );

    final bool isSuccess = await _addToCartProvider.addToCart(
      params,
    );

    if (isSuccess) {
      showSnackBarMessage(context, 'Added to cart');
    } else {
      showSnackBarMessage(
        context,
        _addToCartProvider.errorMessage!,
      );
    }
  }
}