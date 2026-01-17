import 'package:body_checkup/common/widget/app_bar/appbar.dart';
import 'package:body_checkup/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'bmi_controller.dart';

class BMIPage extends StatelessWidget {
  const BMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BMIController());

    return Scaffold(
      appBar: const TAppBar(title: "BMI Calculator", showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const Text(
              "Check your Body Mass Index (BMI) to know if you are in a healthy weight range.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Height Input
            TextFormField(
              controller: controller.height,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Height (cm)",
                prefixIcon: Icon(Iconsax.ruler),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Weight Input
            TextFormField(
              controller: controller.weight,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                prefixIcon: Icon(Iconsax.weight),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Calculate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.calculateBMI(),
                child: const Text("Calculate BMI"),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Result Display
            Obx(
              () => controller.bmiResult.value > 0
                  ? Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: controller.getCategoryColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: controller.getCategoryColor(),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Your BMI: ${controller.bmiResult.value.toStringAsFixed(1)}",
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: controller.getCategoryColor(),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            controller.bmiCategory.value,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: controller.getCategoryColor(),
                                ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
