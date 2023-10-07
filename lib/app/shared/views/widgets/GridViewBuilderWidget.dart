import 'package:flutter/material.dart';


class GridViewBuilderWidget extends StatelessWidget {
  ///
  ///Example :-
  ///
  /// GridViewBuilderWidget(
  ///     crossAxisCount: 2,
  ///     crossAxisSpacing: 8,
  ///     mainAxisSpacing: 8,
  ///     childAspectRatio: 0.55,
  ///     itemCount: controller.wishlist,
  ///     itemBuilder: (BuildContext context, int index) {
  ///     WishlistModel wishlist = controller.wishlist[index];
  ///     return Widget();
  ///    },
  /// ),
  /// =======================================
  ///
  const GridViewBuilderWidget(
      {Key? key,
      this.crossAxisCount,
      this.crossAxisSpacing,
      this.mainAxisSpacing,
      this.childAspectRatio,
      this.padding,
      this.itemCount,
      required this.itemBuilder
      })
      : super(key: key);

  final int? crossAxisCount;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final double? childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? 2,
        crossAxisSpacing: crossAxisSpacing ?? 8,
        mainAxisSpacing: mainAxisSpacing ?? 8,
        childAspectRatio: childAspectRatio ?? 0.55,
      ),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      itemCount: itemCount.length,
      itemBuilder: itemBuilder,
    );
  }
}
