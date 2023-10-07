import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/Global.dart';

class ImageLazyLoad extends StatelessWidget {
  ///
  /// Usage
  ///
  /// ImageLazyLoad(
  ///     imageUrl: "${images[index]}",
  ///     key: UniqueKey(),
  ///   );
  ///
  const ImageLazyLoad(
      {super.key,
      this.height,
      this.width,
      required this.imageUrl,
      this.placeHolder,
      this.padding});

  final double? height;
  final double? width;
  final String imageUrl;
  final String? placeHolder;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 5),
      child: CachedNetworkImage(
        height: height ?? screen.height * 0.3,
        width: width ?? screen.width,
        fit: BoxFit.fill,
        imageUrl: "$imageUrl",
        placeholder: (context, url) => Image.asset(
          placeHolder ?? "assets/placeholders/image-placeholder.gif",
          fit: BoxFit.fill,
          height: height ?? screen.height * 0.3,
          width: width ?? screen.width,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
