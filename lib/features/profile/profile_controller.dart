import 'package:body_checkup/utils/helpers/path_provider.dart';
import 'package:body_checkup/utils/local_storage/storage_utility.dart';

import '../../models/user_model.dart';
import '../../repository/user/user_repository.dart';
import '../../utils/constants/image_strings.dart';

class ProfileController extends GetxController {
  ///Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();

  // New Medical Data
  final dob = TextEditingController();
  final medicalHistory = TextEditingController();
  final prescription = TextEditingController();
  final emergencyMobile = TextEditingController();
  final profileLoader = false.obs;

  final storage = TLocalStorage.instance();
  final profileFormKey = GlobalKey<FormState>();
  final userRepository = Get.put(UserRepoisitory());

  Rx<UserModel> user = UserModel.empty().obs;

  @override
  onInit() {
    super.onInit();
    fetchUserRecords();
  }

  /// Fetch User Records
  Future<void> fetchUserRecords() async {
    try {
      profileLoader.value = true;
      final users = await userRepository.fetchUserDetails();
      this.user(users);
      print("User Name : ${user.value.firstName}");
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
      ///Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      ///Form Validation
      if (!profileFormKey.currentState!.validate()) return;

      ///start loading
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        TImages.dockerAnimation,
      );

      ///Save authendication data in firebase firestore
      final newUser = UserModel(
        id: storage.readData(TTexts.userId),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNo.text.trim(),
        userName: username.text.trim(),
        email: email.text.trim(),
        profilePicture: '',
        emergencyMobile: emergencyMobile.text,
        password: password.text.trim(),
        dob: dob.text,
        medicalHistory: medicalHistory.text,
        prescription: prescription.text,
      );

      final userRepository = Get.put(UserRepoisitory());
      userRepository.saveUserRecord(newUser);
      fetchUserRecords();

      ///Show Success Message
      TLoaders.successSnackBar(
        title: "Congratulation",
        message: 'Updated Successfully',
      );
      TFullScreenLoader.stopLoading();

      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh Snap", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }
}
