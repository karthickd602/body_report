import 'dart:math';
import 'package:body_checkup/models/prediction_model.dart';
import 'package:body_checkup/repository/prediction/prediction_repository.dart';
import 'package:body_checkup/utils/helpers/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PredictionController extends GetxController {
  var bp = 90.obs; // Blood Pressure
  var heartRate = 72.obs; // Heart Rate
  var sugar = 100.obs; // Sugar Level
  var status = "".obs; // Prediction Result
  var allReports = <PatientReportModel>[].obs;

  final predictionRepo = Get.put(PredictionRepository());
  final random = Random();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllReports();
    generateRandomValues();
  }

  void generateRandomValues() {
    // Generate random values
    bp.value = 90 + random.nextInt(50); // BP between 90-140
    heartRate.value = 60 + random.nextInt(60); // HR between 60-120
    sugar.value = 70 + random.nextInt(100); // Sugar between 70-170
    status.value = ""; // Clear status when randomizing
  }

  void predict() {
    int abnormalCount = 0;
    bool isCritical = false;

    // Check Blood Pressure
    if (bp.value < 90 || bp.value > 120) {
      abnormalCount++;
      if (bp.value < 70 || bp.value > 160) isCritical = true;
    }

    // Check Heart Rate
    if (heartRate.value < 60 || heartRate.value > 100) {
      abnormalCount++;
      if (heartRate.value < 50 || heartRate.value > 140) isCritical = true;
    }

    // Check Sugar Level
    if (sugar.value < 70 || sugar.value > 120) {
      abnormalCount++;
      if (sugar.value < 50 || sugar.value > 200) isCritical = true;
    }

    if (abnormalCount == 0) {
      status.value = "Normal ✅";
    } else if (isCritical) {
      status.value = "Critical 🚨";
    } else if (abnormalCount == 1) {
      status.value = "Mild Risk ⚠️";
    } else {
      status.value = "High Risk 🔴";
    }
  }

  /// Fetch all reports
  Future<void> fetchAllReports() async {
    try {
      isLoading.value = true;

      final result = await predictionRepo.fetchAllReports();
      allReports.assignAll(result);
    } catch (e) {
      TLoaders.errorSnackBar(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Save new report
  Future<void> savePrediction() async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Check your internet connection",
        );
        return;
      }
      ;
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final newPrediction = PatientReportModel(
        id: id,
        bloodPressure: bp.value,
        heartRate: heartRate.value,
        sugarLevel: sugar.value,
        status: status.value,
      );

      await predictionRepo.savePrediction(newPrediction);

      TLoaders.successSnackBar(
        title: "Success",
        message: "Prediction saved successfully",
      );

      // Refresh list
      allReports.add(newPrediction);

      // We do not clear the status or generate new values immediately here 
      // so the user can read their prediction result.
    } catch (e) {
      TLoaders.warningSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
