import 'package:body_checkup/common/widget/app_bar/appbar.dart';
import 'package:body_checkup/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'water_tracker_controller.dart';

class WaterTrackerPage extends StatelessWidget {
  const WaterTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WaterTrackerController());

    return Scaffold(
      appBar: const TAppBar(title: "Water Intake Tracker", showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const Text(
              "Stay hydrated! Track your daily water intake.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Progress Circle
            Obx(
              () => CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 20.0,
                percent: controller.progress,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${controller.currentIntake.value} / ${controller.dailyGoal.value} ml",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text("consumed"),
                  ],
                ),
                progressColor: Colors.blue,
                backgroundColor: Colors.blue.withOpacity(0.1),
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Controls
            const Text("Add Water"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAddButton(controller, 100, Iconsax.glass),
                _buildAddButton(
                  controller,
                  250,
                  Iconsax.coffee,
                ), // Coffee cup icon as generic cup
                _buildAddButton(
                  controller,
                  500,
                  Iconsax.milk,
                ), // Milk icon as bottle
              ],
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                controller.currentIntake.value = 0;
                controller.saveData();
              },
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(
    WaterTrackerController controller,
    int amount,
    IconData icon,
  ) {
    return InkWell(
      onTap: () => controller.addWater(amount),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue),
            ),
            child: Icon(icon, size: 30, color: Colors.blue),
          ),
          const SizedBox(height: 5),
          Text("+$amount ml"),
        ],
      ),
    );
  }
}
