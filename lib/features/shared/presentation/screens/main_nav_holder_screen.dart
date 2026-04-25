import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/auth/presentation/screens/withoutConst.dart';
import 'package:crafty_bay/features/home/presentation/providers/home_slider_provider.dart';
import 'package:crafty_bay/features/shared/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Category/presentation/screens/category_list_screen.dart';
import '../../../auth/presentation/screens/withConst.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../wish_list/presentation/screens/wish_list_screen.dart';


class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name = '/main-nav-holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();

}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_){
           context.read<HomeSliderProvider>().getHomeSlider();
           context.read<CategoryListProvider>().getCategories();
        }
    );
  }


  final List<Widget> _screens = [
     HomeScreen(),
     CategoryListScreen(),
     CartScreen(),
     WishListScreen()
   ];

  @override
  Widget build(BuildContext context) {
    // For variable calling
    // MainNavProvider pWatch = context.watch<MainNavProvider>();
    
    return Consumer<MainNavProvider>(
      builder: (context, mainNavProvider, _) {
        return Scaffold(

          body: _screens[mainNavProvider.selectedIndex],

          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.themeColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,

            currentIndex: mainNavProvider.selectedIndex,
            onTap: ( currentIndex ){
              // For function calling
              // context.read<MainNavProvider>().setIndex(currentIndex);
              mainNavProvider.setIndex(currentIndex);
            },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Carts'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Wishlist'),
              ]
          ),
        );
      }
    );
  }
}
