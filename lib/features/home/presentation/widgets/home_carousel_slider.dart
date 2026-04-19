import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/home/presentation/providers/home_slider_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  ValueNotifier<int> _selectedPage = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSliderProvider>(
        builder: (context, homeSliderProvider, _) {
          if (homeSliderProvider.getHomeSliderInProgress) {
            return SizedBox(
                height: 210,
                child: CenterProgressIndicator());
          }
          return Column(
            children: [
              //--------- CarouselSlider widget -----------
              CarouselSlider(
                options: CarouselOptions(
                    height: 200.0,
                    viewportFraction: 1,
                    onPageChanged: (index, pageChangeReason) =>
                    _selectedPage.value = index

                ),

                items: homeSliderProvider.homeSliders.map((slider) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),

                        // alignment: Alignment.center,
                        child: AppNetworkImage(url: slider.photoUrl, borderRadius: 8,),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16,),
              // ------- Custom Circle Indicator -------
              ValueListenableBuilder(
                  valueListenable: _selectedPage,
                  builder: (context, valueListenable, _) {
                    return Row(
                      mainAxisAlignment: .center,
                      spacing: 6,
                      children: [
                        for( int i = 0; i < homeSliderProvider.homeSliders.length; i = i + 1)
                          Container(
                            width: 20,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: valueListenable == i ? AppColors
                                    .themeColor : Colors.transparent,
                                border: BoxBorder.all(color: valueListenable ==
                                    i ? AppColors.themeColor : Colors.grey)
                            ),
                          )
                      ],
                    );
                  }
              )
            ],
          );
        }
    );
  }
}
