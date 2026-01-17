
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  final pagecontroller = PageController();
  Rx<int> currentpageindex = 0.obs;
  ///update Current Index when Page Scroll
  void updatePageIndicator(index) => currentpageindex.value = index;

  /// Jump to the specific dot selected page.
  void dotNavigationClick(index){
    currentpageindex.value= index;
    pagecontroller.jumpTo(index);
  }

  /// Update current index & jump to next page
  void nextPage(){
    if(currentpageindex.value == 2){
      final storage = GetStorage();
      if(kDebugMode){
        print('===========================Get Storage on====================');
        print(storage.read('IsFirstTime'));
      }
      storage.write('IsFirstTime', false);
      if(kDebugMode){
        print('===========================Get Storage on====================');
        print(storage.read('IsFirstTime'));
      }
      Get.offAll(()=> const LoginScreen());
    }else{
      int page = currentpageindex.value+1;
      pagecontroller.jumpToPage(page);
      }
  }

  /// Update current index & jump to the last page
  void skippage(){
    final storage = GetStorage();
    if(kDebugMode){
      print('===========================Get Storage on====================');
      print(storage.read('IsFirstTime'));
    }
    storage.write('IsFirstTime', false);
    if(kDebugMode){
      print('===========================Get Storage on====================');
      print(storage.read('IsFirstTime'));
    }
    Get.offAll(()=> const LoginScreen());
    // currentpageindex.value= 2;
    // pagecontroller.jumpToPage(2);
  }
}