import 'package:body_checkup/common/widget/app_bar/appbar.dart';
import 'package:body_checkup/common/widget/custome%20_shapes/container/rounded_container.dart';
import 'package:body_checkup/features/prediction/prediction_controller.dart';
import 'package:body_checkup/utils/constants/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PredictionPage extends StatelessWidget {
  const PredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PredictionController());

    return Scaffold(
      appBar: TAppBar(title: "Patient Prediction",),
      floatingActionButton: FloatingActionButton(onPressed: (){
        controller.generateRandomValues();
      },backgroundColor: TColors.primary,child: Icon(Icons.repeat,color: Colors.white,),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            /// Auto Generated Values
            Obx(() => Column(
              children: [
                _buildTile("Blood Pressure", "${controller.bp.value} mmHg"),
                _buildTile("Heart Rate", "${controller.heartRate.value} bpm"),
                _buildTile("Sugar Level", "${controller.sugar.value} mg/dL"),
              ],
            )),

            const SizedBox(height: 30),

            /// Predict Button
            SizedBox(

              width: 300,
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.predict();
                  controller.savePrediction();
                },
                icon: const Icon(Iconsax.activity),
                label: const Text("Predict Health"),
              ),
            ),

            const SizedBox(height: 30),

            /// Prediction Result
            Obx(() => Text(
              controller.status.value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: controller.status.value.contains("Normal")
                    ? Colors.green
                    : Colors.red,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(String title, String value) {
    return TRoundedContainer(
showborder: true,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Iconsax.health),
        title: Text(title),
        trailing: Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
