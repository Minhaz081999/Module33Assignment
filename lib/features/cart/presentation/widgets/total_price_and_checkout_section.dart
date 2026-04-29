import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';


class TotalPriceAndCheckoutSection extends StatelessWidget {
  const TotalPriceAndCheckoutSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withAlpha(30),
          borderRadius: .only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16)
          )
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          // ----- Text ------
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                    fontWeight: .w600,
                    color: Colors.black54
                  // minute : 17:25
                ),
              ),
              Text(
                '${Constants.takaSign}${context.read<CartListProvider>().totalPrice}',
                style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.themeColor,
                    fontWeight: .w600
                ),
              ),
            ],
          ),
          // ------ Button -------
          SizedBox(
            width: 120,
            child: FilledButton(
                onPressed: (){},
                child: Text("CheckOut")
            ),
          )
        ],
      ),
    );
  }
}