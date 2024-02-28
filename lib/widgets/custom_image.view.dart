import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    required this.imageUrl,
    this.height = Vx.dp40,
    this.width,
    this.boxFit,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final double height;
  final double? width;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: this.imageUrl,
      fit: this.boxFit ?? BoxFit.cover,
      errorWidget: (context, imageUrl, _) => Image.asset(
        AppImages.noImage,
        fit: this.boxFit ?? BoxFit.cover,
      ),
      progressIndicatorBuilder: (context, imageURL, progress) {
        return Image.asset(AppImages.placeholder);
      },
    ).h(this.height).w(this.width ?? context.percentWidth);
  }
}
