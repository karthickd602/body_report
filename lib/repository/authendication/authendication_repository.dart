import 'package:body_checkup/routes/app_pages.dart';
import 'package:body_checkup/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../features/authendication/screens/login/login.dart';
import '../../features/authendication/screens/onBoarding/onboarding.dart';
import '../../features/authendication/screens/signup/verify_email.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/local_storage/storage_utility.dart';
// import '../user/user_repository.dart';

class AuthendicationRepository extends GetxController {
  static AuthendicationRepository get instance => Get.find();

  /// Variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    screenRedirect();
  }

  ///Screen redirect to relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      /// if user is logged in
      if (user.emailVerified) {
        /// Intialize the user specefic Local storage
        await TLocalStorage.init(user.uid);
     TLocalStorage.instance().saveData(TTexts.userId, user.uid);
        Get.offAllNamed(AppPages.bottomNav);
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const LoginScreen());
    }

    ///Called from main.dart on app launch
    ///Local Storage
  }

  /*--------------------------------Email & Password sign in ---------------------------*/

  /// [EmailAuthentication  LOGIN ] - signing
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("Login 1:${e.code}");
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      print("Login 2:${e.toString()}");
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print("Login 3:");
      throw const TFormatException();
    } on PlatformException catch (e) {
      print("Login 4:${e.toString()}");
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again ';
    }
  }

  /// [Google Signing  LOGIN ] - signing
  Future<UserCredential?> signInWithGoogle() async {
    try {
      ///Triger the authendication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      ///Obtain the auth details from request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      ///create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      ///once signed in return the UserCredential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Some thing wrong $e');
      return null;
    }
  }

  /// [EmailAuthentication create] - Register
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again ';
    }
  }

  /// Email Verifacation  mail verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again ';
    }
  }

  /// Forget password
  Future<void> sendPasswordVerification(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again ';
    }
  }

  /// Re- Authentication
  Future<void> reAuthendicationWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again ';
    }
  }

  /// Logout Function
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      GetStorage().remove(TTexts.userId);
      TLocalStorage.instance().removeData(TTexts.userId);
      Get.offAllNamed(AppPages.login);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again ';
    }
  }

  /// Delete Account
  Future<void> deleteAccount() async {
    try {
      // await UserRepoisitory.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again ';
    }
  }
}
