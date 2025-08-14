import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';


class TCircularCointainer extends StatelessWidget {
  const TCircularCointainer({
    super.key,
    this.child,
    this.width=400,
    this.height=400,
    this.radius=400,
    this.padding=0,
    this.backgroundColor=TColors.white,
    this.margin,
  });
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color:backgroundColor,
      ),
    );
  }
}
