import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WaterTrackerController extends GetxController {
  static WaterTrackerController get instance => Get.find();

  final _storage = GetStorage();
  final dailyGoal = 2000.obs; // ml
  final currentIntake = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    // Reset if it's a new day
    String? lastDate = _storage.read('water_last_date');
    String today = DateTime.now().toIso8601String().split('T')[0];

    if (lastDate != today) {
      currentIntake.value = 0;
      _storage.write('water_last_date', today);
      saveData();
    } else {
      currentIntake.value = _storage.read('water_intake') ?? 0;
      dailyGoal.value = _storage.read('water_goal') ?? 2000;
    }
  }

  void addWater(int amount) {
    currentIntake.value += amount;
    saveData();
  }

  void removeWater(int amount) {
    if (currentIntake.value >= amount) {
      currentIntake.value -= amount;
      saveData();
    }
  }

  void saveData() {
    _storage.write('water_intake', currentIntake.value);
    _storage.write('water_goal', dailyGoal.value);
  }

  double get progress =>
      (currentIntake.value / dailyGoal.value).clamp(0.0, 1.0);
}
