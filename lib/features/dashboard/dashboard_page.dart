import 'package:body_checkup/features/dashboard/step_controller.dart';
import 'package:body_checkup/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../profile/profile_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final stepController = Get.put(StepController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1. Custom Header
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back,",
                            style: Theme.of(context).textTheme.labelMedium!
                                .apply(color: Colors.white.withOpacity(0.8)),
                          ),
                          Obx(
                            () => Text(
                              profileController.user.value.firstName,
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .apply(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      // Profile Image or Placeholder
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(Iconsax.user, color: TColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  /// Steps Card (Integrated in Header)
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Iconsax.activity,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Today's Steps",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${stepController.steps.value}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 2. Medical Info Summary (Compact)
                  Text(
                    "Quick Summary",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Row(
                        children: [
                          _buildInfoCard(
                            context,
                            "Blood Group",
                            profileController.user.value.bloodGroup.isNotEmpty
                                ? profileController.user.value.bloodGroup
                                : "N/A",
                            Iconsax.drop,
                            Colors.red,
                          ),
                          const SizedBox(width: 15),
                          _buildInfoCard(
                            context,
                            "Height",
                            profileController.user.value.height.isNotEmpty
                                ? "${profileController.user.value.height} cm"
                                : "N/A",
                            Iconsax.ruler,
                            Colors.orange,
                          ),
                          const SizedBox(width: 15),
                          _buildInfoCard(
                            context,
                            "Weight",
                            profileController.user.value.weight.isNotEmpty
                                ? "${profileController.user.value.weight} kg"
                                : "N/A",
                            Iconsax.weight,
                            Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 3. All Services Grid
                  Text(
                    "Services & Tools",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.1,
                    children: [
                      _buildDashboardGridTile(
                        context,
                        "Check BMI",
                        "Calculator",
                        Iconsax.calculator,
                        Colors.blue,
                        '/bmi-calculator',
                      ),
                      _buildDashboardGridTile(
                        context,
                        "Water Tracker",
                        "Hydration",
                        Iconsax.glass,
                        Colors.cyan,
                        '/water-tracker',
                      ),
                      _buildDashboardGridTile(
                        context,
                        "Book Appt.",
                        "Find Doctors",
                        Iconsax.calendar_add,
                        Colors.orange,
                        '/appointment-booking',
                      ),
                      _buildDashboardGridTile(
                        context,
                        "Health Tips",
                        "Wellness",
                        Iconsax.heart,
                        Colors.pink,
                        '/health-tips',
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          profileController.callEmergency(
            profileController.user.value.emergencyMobile.toString(),
          );
        },
        backgroundColor: Colors.red, // Emergency color
        child: const Icon(Iconsax.call, color: Colors.white),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardGridTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String route,
  ) {
    return InkWell(
      onTap: () => route.isNotEmpty
          ? Get.toNamed(route)
          : Get.snackbar("Info", "$title Coming Soon"),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
