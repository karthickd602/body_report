import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repository/authendication/authendication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/network/network_manager.dart';
import '../../../../utils/popups/full_screen_loaders.dart';
import '../../../../utils/snackbars/loaders.dart';
import '../../screens/password_configration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// variable
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// send reset password to email
  sendPasswordResetToEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Processing your request...", TImages.dockerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      ///Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthendicationRepository.instance
          .sendPasswordVerification(email.text.trim());
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: "Email Sent",
          message: "Reset Password Link Sent to Your Mail Id");

      Get.to(() => ResetPassword(
            email: email.text.toString(),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh snap", message: e.toString());
    }
  }

  resendPasswordResetToEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Processing your request...", TImages.dockerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthendicationRepository.instance
          .sendPasswordVerification(email.trim());
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: "Email Sent",
          message: "Reset Password Link Sent to Your Mail Id");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh snap", message: e.toString());
    }
  }
}
