import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BMIController extends GetxController {
  static BMIController get instance => Get.find();

  final height = TextEditingController();
  final weight = TextEditingController();
  final bmiResult = 0.0.obs;
  final bmiCategory = "".obs;

  void calculateBMI() {
    if (height.text.isEmpty || weight.text.isEmpty) {
      Get.snackbar("Error", "Please enter both height and weight");
      return;
    }

    try {
      double h = double.parse(height.text) / 100; // Convert cm to meters
      double w = double.parse(weight.text);

      double bmi = w / (h * h);
      bmiResult.value = bmi;

      if (bmi < 18.5) {
        bmiCategory.value = "Underweight";
      } else if (bmi >= 18.5 && bmi < 24.9) {
        bmiCategory.value = "Normal Weight";
      } else if (bmi >= 25 && bmi < 29.9) {
        bmiCategory.value = "Overweight";
      } else {
        bmiCategory.value = "Obesity";
      }
    } catch (e) {
      Get.snackbar("Error", "Invalid input format");
    }
  }

  Color getCategoryColor() {
    switch (bmiCategory.value) {
      case "Underweight":
        return Colors.orange;
      case "Normal Weight":
        return Colors.green;
      case "Overweight":
        return Colors.orangeAccent;
      case "Obesity":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
