import 'package:body_checkup/utils/helpers/path_provider.dart';

import '../../models/user_model.dart';
import '../../repository/user/user_repository.dart';

class ProfileController extends GetxController{


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
  final profileLoader = false.obs;


  final userRepository = Get.put(UserRepoisitory());

  Rx<UserModel> user = UserModel.empty().obs;


  @override
  onInit(){
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
      TLoaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
      user(UserModel.empty());
      profileLoader.value = false;
    } finally {
      profileLoader.value = false;
    }
  }

  Future<void> updateProfile()async{}



}