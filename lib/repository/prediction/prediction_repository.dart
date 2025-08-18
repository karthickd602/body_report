import 'dart:io';

import 'package:body_checkup/utils/local_storage/storage_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../models/prediction_model.dart';
import '../../models/user_model.dart';
import '../../utils/constants/text_strings.dart';
import '../authendication/authendication_repository.dart';

class PredictionRepository extends GetxController {
  static PredictionRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final storage = TLocalStorage.instance();

  /// Save the User Details to Firestore
  Future<void> savePrediction(PatientReportModel patient) async {
    try {
      return await _db.collection('Predictions').doc(patient.id).set(patient.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again ';
    }
  }


  /// 🔹 Fetch all reports of the logged-in user
  Future<List<PatientReportModel>> fetchAllReports() async {
    try {
      final userId = TLocalStorage.instance().readData(TTexts.userId);

      final querySnapshot = await _db
          .collection("Predictions")
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => PatientReportModel.fromSnapshot(doc))
          .toList();

    } catch (e) {
      print(e.toString());
      throw 'Something went wrong: ${e.toString()}';
    }
  }

  /// update the user data
  Future<void> updateUserRecord(UserModel updatedUser) async {
    try {
      return await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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

  /// Update any Field in specfic  users Collection

  Future<void> updateSingleFields(Map<String, dynamic> json) async {
    try {
      return await _db
          .collection('Users')
          .doc(AuthendicationRepository.instance.authUser?.uid)
          .update(json);
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
