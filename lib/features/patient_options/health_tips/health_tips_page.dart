import 'package:body_checkup/common/widget/app_bar/appbar.dart';
import 'package:body_checkup/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HealthTipsPage extends StatelessWidget {
  const HealthTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: "Health Tips", showBackArrow: true),
      body: ListView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        children: [
          _buildTipCard(
            "Drink Water",
            "Drinking water helps maintain the balance of body fluids.",
            Iconsax.glass,
          ),
          _buildTipCard(
            "Daily Exercise",
            "Exercise 30 minutes a day to keep your heart healthy.",
            Iconsax.activity,
          ),
          _buildTipCard(
            "Sleep Well",
            "Get at least 7-8 hours of sleep for mental sharpeness.",
            Iconsax.moon,
          ),
          _buildTipCard(
            "Healthy Diet",
            "Eat more fruits and vegetables.",
            Icons.local_dining,
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
