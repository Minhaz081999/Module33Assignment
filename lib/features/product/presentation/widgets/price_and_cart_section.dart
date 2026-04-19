import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';



class PriceAndCartSection extends StatelessWidget {
  const PriceAndCartSection({
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
                'Price',
                style: TextStyle(
                    fontWeight: .w600,
                    color: Colors.black54
                  // minute : 17:25
                ),
              ),
              Text(
                '${Constants.takaSign}120',
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
                child: Text("Add to Cart")
            ),
          )
        ],
      ),
    );
  }
}