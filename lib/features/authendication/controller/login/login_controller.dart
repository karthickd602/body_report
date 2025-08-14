import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../repository/authendication/authendication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/network/network_manager.dart';
import '../../../../utils/popups/full_screen_loaders.dart';
import '../../../../utils/snackbars/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  ///Variables
  final rememberMe = false.obs;
  final hidePassword = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? '';
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? '';
    super.onInit();
  }

  ///Email and password signIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      ///Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      ///Form Validation
      if (!loginFormKey.currentState!.validate()) {
        return;
      }

      ///start loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.dockerAnimation);
      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      ///Login user using email and password
      await AuthendicationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      TFullScreenLoader.stopLoading();

      // AuthendicationRepository.instance.screenRedirect();

      TLoaders.successSnackBar(
          title: 'Login Successfully', message: email.text.trim());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    }
  }

  ///Google Signing Authentication
  Future<void> googleSignIn() async {
    try {
      ///Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      //start loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.dockerAnimation);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
