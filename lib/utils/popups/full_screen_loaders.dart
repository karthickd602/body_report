import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widget/loaders/animation_loaders.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class TFullScreenLoader{

  static void openLoadingDialog(String texts,String animation){

    showDialog(context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_)=> Center(
          child: PopScope(
              canPop: false,
              child: Container(
                color: THelperFunctions.isDarkMode(Get.context!)?TColors.dark:TColors.white,
                width: double.infinity,
                height: double.infinity,
                child:  Column(
                  children: [
                    SizedBox(height: 250),
                    TAnimationLoaderWidget(text: texts, animation: animation)
                  ],
                ),
          )),
        )
    );
  }

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
}
}