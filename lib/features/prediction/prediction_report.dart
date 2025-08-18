import 'package:body_checkup/features/prediction/prediction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/widget/custome _shapes/container/rounded_container.dart';

class PatientReportPage extends StatelessWidget {
  const PatientReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PredictionController());

    controller.fetchAllReports(); // load all reports

    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Reports"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.allReports.isEmpty) {
          return const Center(
            child: Text(
              "No reports found.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: controller.allReports.length,
          itemBuilder: (BuildContext context, int index) {
            final report = controller.allReports[index];
            return TRoundedContainer(
              radius: 16,
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.white,
              showborder: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Chip(
                        label: Text(
                          report.status,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: report.status == "Normal"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  /// Blood Pressure
                  Row(
                    children: [
                      const Icon(Icons.water_drop, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Blood Pressure",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        "${report.bloodPressure} mmHg",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Heart Rate
                  Row(
                    children: [
                      const Icon(Iconsax.health, color: Colors.pink),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Heart Rate",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        "${report.heartRate} bpm",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Sugar Level
                  Row(
                    children: [
                       Icon(Iconsax.activity, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Sugar Level",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        "${report.sugarLevel} mg/dL",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
