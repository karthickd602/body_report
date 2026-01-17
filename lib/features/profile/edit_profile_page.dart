import 'package:body_checkup/features/profile/profile_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/helpers/path_provider.dart';
import '../authentication/controller/signup/signup_controller.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.profileFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.firstName,
                validator: (value) =>
                    TValidator.validateEmptyField("First Name", value),
                decoration: const InputDecoration(
                  labelText: "First Name",
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                validator: (value) =>
                    TValidator.validateEmptyField("Last Name", value),

                controller: controller.lastName,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                validator: (value) =>
                    TValidator.validateEmptyField("User Name", value),

                readOnly: true,
                controller: controller.username,
                decoration: const InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Iconsax.user_edit),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                readOnly: true,
                validator: (value) =>
                    TValidator.validateEmptyField("Email", value),

                controller: controller.email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Iconsax.direct),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                validator: (value) =>
                    TValidator.validateEmptyField("Phone Number", value),

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
                validator: (value) =>
                    TValidator.validateEmptyField("Date of Birth", value),

                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  prefixIcon: Icon(Iconsax.calendar_1),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.tryParse(controller.dob.text) ??
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
                validator: (value) =>
                    TValidator.validateEmptyField("Medical History", value),

                controller: controller.medicalHistory,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Medical History",
                  prefixIcon: Icon(Iconsax.hospital),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                validator: (value) =>
                    TValidator.validateEmptyField("Prescription", value),
                controller: controller.prescription,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Prescription",
                  prefixIcon: Icon(Iconsax.clipboard_text),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.emergencyMobile,
                validator: (value) =>
                    TValidator.validateEmptyField("Emergency Contact", value),
                decoration: const InputDecoration(
                  labelText: "Emergency Contact",
                  prefixIcon: Icon(Iconsax.call),
                ),
              ),
              const SizedBox(height: 10),

              /// Personal Details Section
              const Divider(),
              const SizedBox(height: 10),
              Text(
                "Personal Details",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 15),

              // Gender & Blood Group Row
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: controller.gender.text.isNotEmpty
                          ? controller.gender.text
                          : null,
                      decoration: const InputDecoration(
                        labelText: "Gender",
                        prefixIcon: Icon(Iconsax.user),
                      ),
                      items: ["Male", "Female", "Other"]
                          .map(
                            (label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.gender.text = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: controller.bloodGroup.text.isNotEmpty
                          ? controller.bloodGroup.text
                          : null,
                      decoration: const InputDecoration(
                        labelText: "Blood Group",
                        prefixIcon: Icon(Iconsax.drop),
                      ),
                      items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                          .map(
                            (label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.bloodGroup.text = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Height & Weight Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.height,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Height (cm)",
                        prefixIcon: Icon(Iconsax.ruler),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: controller.weight,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Weight (kg)",
                        prefixIcon: Icon(Iconsax.weight),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Save updates to backend
                  controller.updateProfile();
                  Get.back(); // Go back to profile page
                },
                icon: Icon(Iconsax.save_2),
                label: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
