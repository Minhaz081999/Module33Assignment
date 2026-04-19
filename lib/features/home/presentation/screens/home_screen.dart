

import 'package:crafty_bay/app/asset_paths.dart';
import 'package:crafty_bay/features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';


import '../widgets/home_app_bar.dart';
import '../widgets/home_category_list.dart';
import '../widgets/home_product_list.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/section_header.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //----- AppBar -----
      appBar:HomeAppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16,),
              ProductSearchBar(),
              const SizedBox(height: 16,),
              HomeCarouselSlider(),
              const SizedBox(height: 16,),
              SectionHeader(title: 'Categories', onTapSeeAll: (){
                context.read<MainNavProvider>().moveToCategory();
              } ),
              const SizedBox(height: 16,),
              HomeCategoryList(),
              const SizedBox(height: 16,),
              SectionHeader(title: 'Popular', onTapSeeAll: (){} ),
              const SizedBox(height: 16,),
              HomeProductList(),
              const SizedBox(height: 16,),
              SectionHeader(title: 'Special', onTapSeeAll: (){} ),
              const SizedBox(height: 16,),
              HomeProductList(),
              const SizedBox(height: 16,),
              SectionHeader(title: 'New', onTapSeeAll: (){} ),
              const SizedBox(height: 16,),
              HomeProductList(),
              const SizedBox(height: 16,),

            ],
          ),
        ),
      ),
    );
  }
}










