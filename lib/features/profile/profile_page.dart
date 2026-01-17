import 'dart:io';
import 'package:body_checkup/features/authentication/screens/login/login.dart';
import 'package:body_checkup/features/profile/profile_controller.dart';
import 'package:body_checkup/repository/authentication/authentication_repository.dart';
import 'package:body_checkup/utils/constants/colors.dart';
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
      backgroundColor: Colors.grey[50], // Light background
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              /// 1. Custom Header with Profile Info
              _buildProfileHeader(context, controller),

              /// 2. Key Stats Row (Overlapping the Header)
              Transform.translate(
                offset: const Offset(0, -40),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildStatsRow(controller),
                ),
              ),

              /// 3. Profile Details Sections
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildSectionHeader("Personal Information"),
                    _buildInfoTile(
                      Iconsax.call,
                      "Phone Number",
                      controller.user.value.phoneNumber,
                    ),
                    _buildInfoTile(
                      Iconsax.calendar_1,
                      "Date of Birth",
                      controller.user.value.dob,
                    ),
                    _buildInfoTile(
                      Iconsax.user,
                      "Gender",
                      controller.user.value.gender,
                    ),
                    _buildInfoTile(
                      Iconsax.drop,
                      "Blood Group",
                      controller.user.value.bloodGroup,
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader("Medical Details"),
                    _buildInfoTile(
                      Iconsax.hospital,
                      "Medical History",
                      controller.user.value.medicalHistory,
                      isLongText: true,
                    ),
                    _buildInfoTile(
                      Iconsax.clipboard_text,
                      "Prescription",
                      controller.user.value.prescription,
                      isLongText: true,
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader("Account Settings"),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Iconsax.logout, color: Colors.red),
                      ),
                      title: const Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () => AuthenticationRepository.instance.logout(),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    ProfileController controller,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 60, left: 20, right: 20),
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: controller.profilePicture.value.isNotEmpty
                    ? FileImage(File(controller.profilePicture.value))
                    : null,
                child: controller.profilePicture.value.isEmpty
                    ? const Icon(Iconsax.user, size: 50, color: TColors.primary)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () => _showImagePickerOptions(context, controller),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.camera,
                      size: 20,
                      color: TColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            controller.user.value.fullname,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            controller.user.value.email,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: Colors.white.withOpacity(0.8)),
          ),
          const SizedBox(height: 20),

          /// Edit Profile Button
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const EditProfilePage()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                side: BorderSide.none,
                shape: const StadiumBorder(),
              ),
              child: const Text("Edit Profile"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem("Blood", controller.user.value.bloodGroup),
          _buildDivider(),
          _buildStatItem("Height", "${controller.user.value.height} cm"),
          _buildDivider(),
          _buildStatItem("Weight", "${controller.user.value.weight} kg"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value.isEmpty || value == " cm" || value == " kg" ? "-" : value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.3));
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String title,
    String value, {
    bool isLongText = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: isLongText
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: TColors.primary, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 5),
                Text(
                  value.isEmpty ? "Not set" : value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePickerOptions(
    BuildContext context,
    ProfileController controller,
  ) {
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
