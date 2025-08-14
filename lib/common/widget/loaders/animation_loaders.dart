import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/path_provider.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget(
      {
      super.key,
      required this.text,
      required this.animation,
      this.showAction=false,
      this.actionText,
      this.onActionPressed
      });

  final String text, animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(animation,width: THelperFunctions.screenWidth()*0.8),
          SizedBox(height: TSizes.defaultSpace,),
          Text(text,style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,),
          SizedBox(height: TSizes.defaultSpace,),
          showAction?SizedBox(width: 250,
          child: OutlinedButton(
            onPressed: onActionPressed,
            style: OutlinedButton.styleFrom(backgroundColor: TColors.dark),child: Text(actionText!,style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.light),
          ),
          ),):SizedBox()
        ],
      ),
    );
  }
}
