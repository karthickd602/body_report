import 'package:body_checkup/common/widget/custome%20_shapes/container/rounded_container.dart';
import 'package:body_checkup/features/dashboard/step_controller.dart';
import 'package:body_checkup/features/prediction/prediction_report.dart';
import 'package:body_checkup/utils/constants/path_provider.dart';
import 'package:body_checkup/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/widget/app_bar/appbar.dart';
import '../profile/profile_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final stepController = Get.put(StepController());

    return Scaffold(
      appBar: TAppBar(title: 'Dashboard',),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Greeting
            Text(
              "Welcome, ${profileController.user.value.firstName} 👋",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),

            /// Step Count Card (Reactive)
            Obx(() =>TRoundedContainer(
              showborder: true,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                     Icon(Iconsax.activity,
                        size: 40, color: Colors.blue),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Today's Steps",
                            style: TextStyle(fontSize: 16)),
                        Text(
                          "${stepController.steps.value}",
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
            const SizedBox(height: 20),

            /// Medical Info Summary
            Text("Medical Info",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Obx(
              ()=> Column(
                children: [
                  _buildTile("Date of Birth", profileController.user.value.dob),
                  InkWell(onTap: ()=>Get.to(()=>PatientReportPage()),child:  _buildTile("Medical History", profileController.user.value.medicalHistory)),
                  _buildTile("Prescription", profileController.user.value.prescription),

                ],
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Iconsax.call,color: Colors.white,),backgroundColor: TColors.primary,),
    );
  }

  Widget _buildTile(String title, String value) {
    return TRoundedContainer(
      showborder: true,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value.isEmpty ? "-" : value),
      ),
    );
  }
}
