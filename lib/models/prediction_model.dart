import 'package:body_checkup/utils/local_storage/storage_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/constants/text_strings.dart';

class PatientReportModel {
  final String id;
  final int bloodPressure; // e.g. 120
  final int heartRate;     // e.g. 72
  final int sugarLevel;    // e.g. 95
  final String status;     // e.g. "Normal" or "Abnormal"
  final String? userId;

  PatientReportModel({
    required this.id,
    required this.bloodPressure,
    required this.heartRate,
    required this.sugarLevel,
    required this.status,
    this.userId,
  });

  /// Convert from JSON (Map)
  factory PatientReportModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return PatientReportModel(
      id: docId ?? json['id'] ?? '',
      bloodPressure: (json['bloodPressure'] ?? 0) as int,
      heartRate: (json['heartRate'] ?? 0) as int,
      sugarLevel: (json['sugarLevel'] ?? 0) as int,
      status: json['status'] ?? '',
      userId: json['userId'],
    );
  }

  /// From Firestore DocumentSnapshot
  factory PatientReportModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return PatientReportModel.fromJson(data, docId: document.id);
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "bloodPressure": bloodPressure,
      "heartRate": heartRate,
      "sugarLevel": sugarLevel,
      "status": status,
      "userId": userId ?? TLocalStorage.instance().readData(TTexts.userId),
    };
  }
}
