import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';


class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({super.key});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  ValueNotifier<int> _selectedPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //--------- CarouselSlider widget -----------
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            viewportFraction: 1,
            onPageChanged: (index, pageChangeReason) => _selectedPage.value = index

          ),

          items: [1,2,3,4,5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(100),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16,),

        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          // ------- Custom Circle Indicator -------
          child: ValueListenableBuilder(
            valueListenable: _selectedPage,
            builder: (context, valueListenable, _) {
              return Row(
                mainAxisAlignment: .center,
                spacing: 6,
                children: [
                  for( int i = 0; i<5; i = i +1)
                  Container(
                    width: 20,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        color: valueListenable == i ? AppColors.themeColor : Colors.white,
                      border: BoxBorder.all(color: valueListenable == i ? AppColors.themeColor : Colors.grey)
                    ),
                  )
                ],
              );
            }
          ),
        )
      ],
    );
  }
}
