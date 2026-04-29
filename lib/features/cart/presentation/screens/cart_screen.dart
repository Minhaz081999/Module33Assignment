
import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_provider.dart';
import '../../../shared/presentation/widgets/cart_item.dart';

import '../widgets/total_price_and_checkout_section.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  CartListProvider _cartListProvider = CartListProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartListProvider.getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _cartListProvider,
      child: PopScope(
        // 'true' -> hole backButton click korle App theke ber kore dibe
        // 'false' -> hole backButton click korle Home() page niye jabe
        canPop: false, // False or True
        onPopInvokedWithResult:(bool canPop, dynamic result)async{
          if (canPop) {
            return;
          } else {
            context.read<MainNavProvider>().backToHome();
          }
        },
        child: Scaffold(
          //---------- app bar ---------------
            appBar: AppBar(
              title: Text('Categories'),
              leading: IconButton(onPressed: () async {
                context.read<MainNavProvider>().backToHome();
              }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
            ),
            //----------- Listview and Button -------------------
            body: Consumer<CartListProvider>(
              builder: (context, _, _ ) {

                if(_cartListProvider.getCartListInProgress){
                  return CenterProgressIndicator();
                }

                return Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemCount:_cartListProvider.cartList.length,
                          itemBuilder: (context, index) =>
                          CartItem(cartModel: _cartListProvider.cartList[index], ),
                        )
                    ),
                    TotalPriceAndCheckoutSection()
                  ],
                );
              }
            )

        ),
      ),
    );
  }
}



