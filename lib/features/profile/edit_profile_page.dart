import 'package:body_checkup/features/profile/profile_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/helpers/path_provider.dart';
import '../authendication/controller/signup/signup_controller.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: controller.firstName,
              decoration: const InputDecoration(
                labelText: "First Name",
                prefixIcon: Icon(Iconsax.user),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: controller.lastName,
              decoration: const InputDecoration(
                labelText: "Last Name",
                prefixIcon: Icon(Iconsax.user),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              readOnly:true,
              controller: controller.username,
              decoration: const InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Iconsax.user_edit),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              readOnly: true,
              controller: controller.email,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Iconsax.direct),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(

              readOnly: true,
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                labelText: "Phone",
                prefixIcon: Icon(Iconsax.call),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: controller.dob,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Date of Birth",
                prefixIcon: Icon(Iconsax.calendar_1),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.tryParse(controller.dob.text) ??
                      DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  controller.dob.text =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: controller.medicalHistory,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Medical History",
                prefixIcon: Icon(Iconsax.hospital),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: controller.prescription,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Prescription",
                prefixIcon: Icon(Iconsax.clipboard_text),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Save updates to backend
                controller.updateProfile();
                Get.back(); // Go back to profile page
              },
              icon:  Icon(Iconsax.save_2),
              label: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
