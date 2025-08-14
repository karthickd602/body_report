import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../style/spacing_style.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onpressed});
  final String image,title,subtitle;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: TSpacingStyle.paddingwithappbarweight*2,
          child: Column(
            children: [
              ///Images
              Lottie.asset(image,width: THelperFunctions.screenWidth()*0.6),
              // Image(image: AssetImage(image),width: THelperFunctions.screenWidth()*0.6,),
               SizedBox(height: TSizes.spaceBtwSections,),

              ///Title & SubTitle
              Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwSections,),
              Text(subtitle,style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              ///Buttons

              SizedBox(width:double.infinity,child: ElevatedButton(onPressed: onpressed, child: const Text(TTexts.tContinue))),
            ],
          ),
        ),

      ),
    );
  }
}
