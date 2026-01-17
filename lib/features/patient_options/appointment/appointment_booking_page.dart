import 'package:body_checkup/common/widget/app_bar/appbar.dart';
import 'package:body_checkup/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppointmentBookingPage extends StatelessWidget {
  const AppointmentBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: "Book Appointment", showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const Text("Select a Doctor"),
            const SizedBox(height: 10),
            // Mock Doctor List
            _buildDoctorCard(context, "Dr. Smith", "Cardiologist", "4.8"),
            _buildDoctorCard(context, "Dr. Emily", "Dentist", "4.9"),
            _buildDoctorCard(context, "Dr. John", "General Physician", "4.5"),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(
    BuildContext context,
    String name,
    String speciality,
    String rating,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Iconsax.user_tag)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(speciality),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.orange, size: 16),
            Text(rating),
          ],
        ),
        onTap: () {
          Get.snackbar("Booking", "Booking feature coming soon for $name");
        },
      ),
    );
  }
}
