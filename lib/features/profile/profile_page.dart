import 'package:body_checkup/features/authendication/screens/login/login.dart';
import 'package:body_checkup/features/profile/profile_controller.dart';
import 'package:body_checkup/repository/authendication/authendication_repository.dart';
import 'package:body_checkup/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.edit),
            onPressed: () {
              Get.to(() => const EditProfilePage());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          ()=> ListView(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                child: const Icon(Iconsax.user, size: 50),
              ),
              const SizedBox(height: 20),

              _buildTile("First Name", controller.user.value.firstName),
              _buildTile("Last Name", controller.user.value.lastName),
              _buildTile("Username", controller.user.value.userName),
              _buildTile("Email", controller.user.value.email),
              _buildTile("Phone", controller.user.value.phoneNumber),
              _buildTile("Date of Birth", controller.user.value.dob),
              _buildTile("Medical History", controller.user.value.medicalHistory),
              _buildTile("Prescription", controller.user.value.prescription),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red,side: BorderSide(color: Colors.red)),
                onPressed: () {
                  AuthendicationRepository.instance.logout();
                },
                icon: const Icon(Iconsax.logout),
                label: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(String title, String value) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value.isEmpty ? "-" : value),
    );
  }
}
