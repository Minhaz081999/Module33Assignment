import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/product/presentation/widgets/price_and_cart_section.dart';
import 'package:crafty_bay/features/product/presentation/widgets/product_image_carousel.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../widgets/color_picker.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ----- Carousel Slider -------
                  ProductImageCarousel(),
                  // ------ Text,Text, Button, Color Picker, Size Picker ---------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),

                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        const SizedBox(height: 16),
                        // Text,Button
                        Row(
                          crossAxisAlignment: .start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                mainAxisAlignment: .start,
                                children: [
                                  Text(
                                    'NIKE New Shoe DF3434K 2026 Edition',
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: .w600),
                                  ),
                                  Row(
                                    spacing: 8,
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
                                          borderRadius: .circular(8),
                                        ),
                                        child: Icon(
                                          Icons.favorite_outline,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Button
                            IncDecButton(
                              onChange: (newValue) {
                                print('$newValue');
                              },
                            ),
                          ],
                        ),
                        // ------ Colors Picker -----------
                        ColorPicker(
                          initialValue: 'red',
                          colors: ['red', 'green', 'blue', 'yellow', 'orange'],
                          onSelected: (String selectedColor) {
                            print(selectedColor);
                          },
                        ),
                        const SizedBox(height: 16),
                        //-------- Sizes Picker --------
                        SizePicker(
                          initialValue: 'red',
                          sizes: ['s', 'm', 'l', 'xl', 'xxl'],
                          onSelected: (String selectedSize) {
                            print(selectedSize);
                          },
                        ),
                        const SizedBox(height: 16,),
                        Text('Description',style: context.textTheme.bodyLarge
                            ?.copyWith(fontWeight: .w600),),
                        const SizedBox(height: 8,),
                        Text('''Dummy description about shoes. ''',style: TextStyle(color: Colors.black54),),
                        const SizedBox(height: 16,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ------ Text, Button -------
          PriceAndCartSection(),
        ],
      ),
    );
  }
}
