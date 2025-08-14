import 'package:get_storage/get_storage.dart';

import '../../routes/app_pages.dart';
import '../../utils/helpers/path_provider.dart';

class SplashController extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 4), () {
      validate();
    });
    super.onInit();
  }

  void validate() async {


    // Get.offNamed(AppPages.bottomNav);
    Get.offNamed(AppPages.login);
  }
}
