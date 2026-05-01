import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:crafty_bay/features/wish_list/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/center_progress_indicator.dart';
import '../../../shared/presentation/widgets/product_card.dart';


class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final WishListProvider _wishListProvider = WishListProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // স্ক্রিন ওপেন হওয়ার সাথে সাথে প্রথম পেজের ডাটা ফেচ করবে
      _wishListProvider.getWishListItems();
      // স্ক্রল লিসেনার অ্যাড করা হলো পেজিনেশনের জন্য
      _scrollController.addListener(_loadMore);
    });
  }
  void _loadMore() {
    if (_wishListProvider.isLoading) {
      return;
    }
    // ইউজার যখন নিচে ৩শ পিক্সেল বাকি থাকবে তখন নেক্সট পেজ লোড করবে
    if (_scrollController.position.extentAfter < 300) {
      _wishListProvider.getWishListItems();
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult : (bool canPop, dynamic result ){
        context.read<MainNavProvider>().backToHome();
      },
      child: ChangeNotifierProvider.value(
        value: _wishListProvider,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Wish List'),
            leading: IconButton(
                onPressed: () => context.read<MainNavProvider>().backToHome(),
                icon: Icon(Icons.arrow_back_ios_new_outlined)
            ),
          ),
          body: Consumer<WishListProvider>(
            builder: (context, wishListProvider, _) {
              // প্রথমবার ডাটা লোড হওয়ার সময় লোডার দেখাবে
              if (wishListProvider.getInitialDataInProgress) {
                return const CenterProgressIndicator();
              }
              // ডাটা না থাকলে মেসেজ দেখাবে
              if (wishListProvider.wishListItems.isEmpty) {
                return const Center(child: Text('Wishlist is empty'));
              }
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5
                        ),
                        itemCount: wishListProvider.wishListItems.length,
                        itemBuilder: (context, index ){
                          // minutes : 41:36
                          return FittedBox(child: ProductCard(
                            productModel: wishListProvider.wishListItems[index].product,
                          ));
                        }),
                  ),
                  // নিচে আরও ডাটা লোড হওয়ার সময় ইন্ডিকেটর দেখাবে
                  if (wishListProvider.getMoreDataInProgress)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                ],
              );
            }
          ),

        ),
      ),
    );
  }
}
