import 'dart:math';
import 'package:body_checkup/models/prediction_model.dart';
import 'package:body_checkup/repository/prediction/prediction_repository.dart';
import 'package:body_checkup/utils/helpers/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PredictionController extends GetxController {
  var bp = 0.obs;          // Blood Pressure
  var heartRate = 0.obs;   // Heart Rate
  var sugar = 0.obs;       // Sugar Level
  var status = "".obs;     // Prediction Result
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
    bp.value = 90 + random.nextInt(50);        // BP between 90-140
    heartRate.value = 60 + random.nextInt(60); // HR between 60-120
    sugar.value = 70 + random.nextInt(100);    // Sugar between 70-170

  }

  void predict() {
    // Evaluate health status
    if (_isNormal(bp.value, heartRate.value, sugar.value)) {
      status.value = "Normal ✅";
    } else {
      status.value = "Abnormal ⚠️";
    }
  }

  bool _isNormal(int bp, int hr, int sugar) {
    return (bp >= 90 && bp <= 120) &&
        (hr >= 60 && hr <= 100) &&
        (sugar >= 70 && sugar <= 120);
  }


  /// Fetch all reports
  Future<void> fetchAllReports() async {
    try {
      isLoading.value = true;

      final result = await predictionRepo.fetchAllReports();
      allReports.assignAll(result);
    } catch (e) {
TLoaders.errorSnackBar(message: e.toString());    } finally {
      isLoading.value = false;
    }
  }

  /// Save new report
  Future<void> savePrediction() async {

    try {
      final connected =  await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(title: "No Internet",message: "Check your internet connection");
        return;
      };
      final id =DateTime.now().microsecondsSinceEpoch.toString();
      final newPrediction = PatientReportModel(id: id, bloodPressure: bp.value, heartRate: heartRate.value, sugarLevel: sugar.value, status: status.value);

      predictionRepo.savePrediction(newPrediction);

      TLoaders.successSnackBar(title: "Success",message: "Prediction saved successfully");
      bp.value = 0;
      heartRate.value = 0;
      sugar.value = 0;
    }catch(e){
      TLoaders.warningSnackBar(title:"Oh Snap!",message: e.toString());
    }
  }
}
