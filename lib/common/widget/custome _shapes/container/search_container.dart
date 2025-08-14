import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';


class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon= Iconsax.search_normal,
    this.showbackground=true,
    this.showborder=true,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showbackground,showborder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: padding,
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
          color: showbackground? dark? TColors.dark:TColors.light:Colors.transparent,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border: showborder?Border.all(color: TColors.grey):null,
        ),
        child: Row(
          children: [
            Icon(icon,color: TColors.darkerGrey,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text(text,style: Theme.of(context).textTheme.bodySmall,),
            const SizedBox(width: TSizes.spaceBtwItems,),


          ],
        ),
      ),
    );
  }
}
