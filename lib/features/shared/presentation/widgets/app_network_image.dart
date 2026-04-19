import 'package:crafty_bay/features/shared/presentation/widgets/center_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'no_image.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.borderRadius
  });

  final String url;
  final double ? width;
  final double ? height;
  final BoxFit ?  fit  ;
  final double ? borderRadius;
  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: .circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit ?? BoxFit.fill,
        // placeholder: (context,url)=> NoImage(),
        errorWidget: (context,url, error)=> NoImage(),
      progressIndicatorBuilder: (context,url, downloadProgress)=> NoImage()
      ),
    );
  }
}
