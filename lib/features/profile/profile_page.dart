import 'dart:io';
import 'package:body_checkup/features/authendication/screens/login/login.dart';
import 'package:body_checkup/features/profile/profile_controller.dart';
import 'package:body_checkup/repository/authendication/authendication_repository.dart';
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
              () => ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade100,
                      backgroundImage: controller.profilePicture.value.isNotEmpty
                          ? FileImage(File(controller.profilePicture.value))
                          : null,
                      child: controller.profilePicture.value.isEmpty
                          ? const Icon(Iconsax.user, size: 60)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          _showImagePickerOptions(context, controller);
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: Icon(Iconsax.camera, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
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

  void _showImagePickerOptions(
      BuildContext context, ProfileController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Iconsax.image),
              title: const Text("Pick from Gallery"),
              onTap: () {
                controller.pickProfilePicture(fromCamera: false);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.camera),
              title: const Text("Take a Photo"),
              onTap: () {
                controller.pickProfilePicture(fromCamera: true);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
