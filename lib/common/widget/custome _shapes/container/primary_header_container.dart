import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curve_edges_widget.dart';
import 'circular_container.dart';



class TPrimaryHeadersContainer extends StatelessWidget {
  const TPrimaryHeadersContainer({
    super.key, required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurveEdgeWidget(child: Container(
      color: TColors.primary,
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Positioned(top: -150, right: -250,
              child: TCircularCointainer(backgroundColor: TColors.textWhite.withOpacity(0.1),)),
          Positioned(top: 100,right: -300,
              child: TCircularCointainer(backgroundColor: TColors.textWhite.withOpacity(0.1),)),
          child

        ],
      ),
    )
    );
  }
}

