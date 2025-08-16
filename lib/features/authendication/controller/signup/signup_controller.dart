import '../../../../models/user_model.dart';
import '../../../../repository/authendication/authendication_repository.dart';
import '../../../../repository/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/path_provider.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///Variables
  final hidePassword = true.obs;
  final privacyPolicyCheck = true.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final authRepo =
  Get.put(AuthendicationRepository());

  // New Medical Data
  final age = TextEditingController();
  final medicalHistory = TextEditingController();
  final prescription = TextEditingController();

  // File Upload
  var prescriptionFileName = "".obs;


  Future<void> pickPrescriptionFile() async {
    // You can use file_picker or image_picker package
    // Example:
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   prescriptionFileName.value = result.files.single.name;
    // }
  }

  void signup() async {
    try {
      ///Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      ///Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      ///privacy policy check
      if (!privacyPolicyCheck.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use');
        return;
      }

      ///start loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.dockerAnimation);

      ///Register user in the firebase
      final userCredential = await authRepo.registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      ///Save authendication data in firebase firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          phoneNumber: phoneNo.text.trim(),
          userName: username.text.trim(),
          email: email.text.trim(),
          profilePicture: '',
          password: password.text.trim());

      final userRepository = Get.put(UserRepoisitory());
      userRepository.saveUserRecord(newUser);
      TFullScreenLoader.stopLoading();

      ///Show Success Message
      TLoaders.successSnackBar(
          title: "Congratulation",
          message: 'Your Account has been created! Verify email to continue');

      ///Move to verify Email Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh Snap", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }
}
