import 'package:crafty_bay/app/asset_paths.dart';
import 'package:flutter/material.dart';


class NoImage extends StatelessWidget {
  const NoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetPaths.noImagePng
    );
  }
}
