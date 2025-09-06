import 'dart:io';
import 'package:body_checkup/models/user_model.dart';
import 'package:body_checkup/repository/user/user_repository.dart';
import 'package:body_checkup/utils/constants/image_strings.dart';
import 'package:body_checkup/utils/helpers/path_provider.dart';
import 'package:body_checkup/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  /// Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();
final isLoading = false.obs;
  // Medical Data
  final dob = TextEditingController();
  final medicalHistory = TextEditingController();
  final prescription = TextEditingController();
  final emergencyMobile = TextEditingController();
  final profileLoader = false.obs;

  final storage = TLocalStorage.instance();
  final profileFormKey = GlobalKey<FormState>();
  final userRepository = Get.put(UserRepoisitory());

  Rx<UserModel> user = UserModel.empty().obs;

  /// Profile picture (local path)
  RxString profilePicture = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecords();
    loadProfilePicture();
  }

  /// Pick image from gallery/camera
  Future<void> pickProfilePicture({bool fromCamera = false}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      profilePicture.value = pickedFile.path;

      /// Save in local storage
      await storage.saveData("profile_picture", pickedFile.path);
    }
  }

  /// Load saved profile picture
  void loadProfilePicture() {
    final savedPath = storage.readData("profile_picture");
    if (savedPath != null && savedPath.isNotEmpty) {
      profilePicture.value = savedPath;
    }
  }

  /// Fetch User Records
  Future<void> fetchUserRecords() async {
    try {
      profileLoader.value = true;

      print("USerId ---- ${storage.readData(TTexts.userId)}");
      final users = await userRepository.fetchUserDetails();
      user(users);

      firstName.text = user.value.firstName;
      lastName.text = user.value.lastName;
      username.text = user.value.userName;
      email.text = user.value.email;
      phoneNo.text = user.value.phoneNumber;
      dob.text = user.value.dob;
      medicalHistory.text = user.value.medicalHistory;
      prescription.text = user.value.prescription;
      profileLoader.value = false;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      user(UserModel.empty());
      profileLoader.value = false;
    } finally {
      profileLoader.value = false;
    }
  }

  void updateProfile() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      if (!profileFormKey.currentState!.validate()) return;

      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        TImages.dockerAnimation,
      );

      final newUser = UserModel(
        id: storage.readData(TTexts.userId),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNo.text.trim(),
        userName: username.text.trim(),
        email: email.text.trim(),
        profilePicture: profilePicture.value, // save local path
        emergencyMobile: emergencyMobile.text,
        password: password.text.trim(),
        dob: dob.text,
        medicalHistory: medicalHistory.text,
        prescription: prescription.text,
      );

      final userRepository = Get.put(UserRepoisitory());
      await userRepository.saveUserRecord(newUser);
      fetchUserRecords();

      TLoaders.successSnackBar(
        title: "Congratulation",
        message: 'Updated Successfully',
      );
      TFullScreenLoader.stopLoading();

      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> callEmergency(String number) async {
    final Uri uri = Uri(scheme: "tel", path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not call $number");
    }
  }
}
