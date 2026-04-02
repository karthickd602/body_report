import 'package:body_checkup/common/widget/app_bar/appbar.dart';
import 'package:body_checkup/common/widget/custome%20_shapes/container/rounded_container.dart';
import 'package:body_checkup/features/prediction/prediction_controller.dart';
import 'package:body_checkup/utils/constants/colors.dart';
import 'package:body_checkup/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PredictionPage extends StatelessWidget {
  const PredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PredictionController());

    return Scaffold(
      appBar: const TAppBar(title: "Patient Prediction", showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Input Section
            Text(
              "Enter Vitals",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            Obx(
              () => _buildSliderTile(
                context,
                "Blood Pressure",
                "${controller.bp.value.toInt()} mmHg",
                controller.bp.value.toDouble(),
                60,
                200,
                (val) => controller.bp.value = val.toInt(),
                Iconsax.activity,
              ),
            ),
            const SizedBox(height: 10),

            Obx(
              () => _buildSliderTile(
                context,
                "Heart Rate",
                "${controller.heartRate.value.toInt()} bpm",
                controller.heartRate.value.toDouble(),
                40,
                180,
                (val) => controller.heartRate.value = val.toInt(),
                Iconsax.heart,
              ),
            ),
            const SizedBox(height: 10),

            Obx(
              () => _buildSliderTile(
                context,
                "Sugar Level",
                "${controller.sugar.value.toInt()} mg/dL",
                controller.sugar.value.toDouble(),
                50,
                300,
                (val) => controller.sugar.value = val.toInt(),
                Iconsax.health,
              ),
            ),

            const SizedBox(height: 20),

            /// Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.generateRandomValues,
                    child: const Text("Randomize"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.predict();
                      controller.savePrediction();
                    },
                    child: const Text("Predict & Save"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Result Display
            Obx(
              () => controller.status.value.isNotEmpty
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _getStatusColor(controller.status.value).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getStatusColor(controller.status.value),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Prediction Result",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.status.value,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(controller.status.value),
                            ),
                          ),
                          if (controller.status.value.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                _getMedicalAdvice(
                                  controller.status.value,
                                  controller,
                                ),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: _getStatusColor(controller.status.value),
                                      height: 1.4,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 30),
            Divider(color: Colors.grey.withOpacity(0.2)),
            const SizedBox(height: 10),

            /// History Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Prediction History",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: controller.fetchAllReports,
                  icon: const Icon(Icons.refresh, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Obx(() {
              if (controller.isLoading.value)
                return const Center(child: CircularProgressIndicator());
              if (controller.allReports.isEmpty)
                return const Center(child: Text("No history available"));

              return Column(
                children: controller.allReports
                    .map(
                      (report) => TRoundedContainer(
                        showborder: true,
                        margin: const EdgeInsets.only(bottom: 10),
                        backgroundColor: Colors.transparent,
                        child: ListTile(
                          leading: Icon(
                            Iconsax.health,
                            color: _getStatusColor(report.status),
                          ),
                          title: Text(
                            "BP: ${report.bloodPressure} | HR: ${report.heartRate}",
                          ),
                          subtitle: Text(
                            "Sugar: ${report.sugarLevel}",
                          ),
                          trailing: Text(
                            report.status,
                            style: TextStyle(
                              color: _getStatusColor(report.status),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status.contains("Normal")) return Colors.green;
    if (status.contains("Mild Risk")) return Colors.orange;
    if (status.contains("Critical")) return Colors.red[900]!;
    return Colors.red;
  }

  String _getMedicalAdvice(String status, PredictionController controller) {
    if (status.contains("Normal")) {
      return "Everything looks great! Keep up the healthy lifestyle with regular exercise and a balanced diet.";
    } else {
      List<String> advice = [];

      if (controller.bp.value > 120) {
        advice.add(
          "• Manage your blood pressure by reducing sodium and stress.",
        );
      } else if (controller.bp.value < 90) {
        advice.add(
          "• Your blood pressure is low; stay hydrated and eat regular meals.",
        );
      }

      if (controller.heartRate.value > 100) {
        advice.add(
          "• Your heart rate is high; try to relax and avoid caffeine.",
        );
      } else if (controller.heartRate.value < 60) {
        advice.add(
          "• Your heart rate is low; consult a doctor if you feel dizzy or weak.",
        );
      }

      if (controller.sugar.value > 120) {
        advice.add(
          "• High sugar level detected; limit intake of sweets and refined carbs.",
        );
      } else if (controller.sugar.value < 70) {
        advice.add(
          "• Low sugar level detected; consume fast-acting carbohydrates like fruit juice.",
        );
      }

      if (status.contains("Critical")) {
        advice.add(
          "\n🚨 URGENT: Your vitals are in the critical range! Please seek immediate medical assistance.",
        );
      } else {
        advice.add(
          "\nNote: Please consult a healthcare professional for accurate diagnosis and treatment.",
        );
      }
      return advice.join("\n");
    }
  }

  Widget _buildSliderTile(
    BuildContext context,
    String title,
    String valueLabel,
    double value,
    double min,
    double max,
    Function(double) onChanged,
    IconData icon,
  ) {
    return TRoundedContainer(
      showborder: true,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: TColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                valueLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            label: value.round().toString(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
