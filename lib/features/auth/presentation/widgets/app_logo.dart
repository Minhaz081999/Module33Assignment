import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/asset_paths.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.height = 140,  this.width = 140
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetPaths.logoSvg,
      width: width,
      height: height,
    );
  }
}