import 'package:body_checkup/features/authendication/screens/signup/widget/terms_and_condition.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/helpers/path_provider.dart';
import '../../../controller/signup/signup_controller.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// --- Existing Name Fields ---
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.firstName,
                      validator: (value) => TValidator.validateEmptyField(
                          TTexts.firstName, value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user),
                        labelText: TTexts.firstName,
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.lastName,
                      validator: (value) => TValidator.validateEmptyField(
                          TTexts.lastName, value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user),
                        labelText: TTexts.lastName,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// --- Username ---
              TextFormField(
                controller: controller.username,
                validator: (value) =>
                    TValidator.validateEmptyField(TTexts.username, value),
                decoration: const InputDecoration(
                  labelText: TTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// --- Email ---
              TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// --- Phone Number ---
              TextFormField(
                controller: controller.phoneNo,
                validator: (value) => TValidator.validatePhoneNumber(value),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                buildCounter: (context,
                    {required int currentLength,
                      required int? maxLength,
                      required bool isFocused}) {
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: TTexts.phoneNo,
                  prefixIcon: Icon(Iconsax.call),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// --- Password ---
              Obx(
                    () => TextFormField(
                  controller: controller.password,
                  validator: (value) => TValidator.validatePassword(value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // =========================
              //   MEDICAL INFORMATION
              // =========================

              /// Age
              /// Date of Birth
              TextFormField(
                controller: controller.dob,
                readOnly: true, // Prevent manual typing
                validator: (value) =>
                    TValidator.validateEmptyField("Date of Birth", value),
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  prefixIcon: Icon(Iconsax.calendar_1),
                  suffixIcon: Icon(Iconsax.calendar), // calendar icon
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000), // default
                    firstDate: DateTime(1900), // minimum DOB
                    lastDate: DateTime.now(), // today (cannot pick future)
                  );

                  if (pickedDate != null) {
                    controller.dob.text = THelperFunctions.getFormattedDate(pickedDate);
                    // controller.dob.text =
                    // "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Medical Conditions
              TextFormField(
                controller: controller.medicalHistory,
                maxLines: 3,
                validator: (value) => TValidator.validateEmptyField(
                    "Medical History", value),
                decoration: const InputDecoration(
                  labelText: "Medical History / Conditions",
                  prefixIcon: Icon(Iconsax.hospital),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Prescription (text input)
              TextFormField(
                controller: controller.prescription,
                maxLines: 3,
                validator: (value) =>
                    TValidator.validateEmptyField("Prescription", value),
                decoration: const InputDecoration(
                  labelText: "Prescription",
                  prefixIcon: Icon(Iconsax.clipboard_text),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              Obx(() => Text(
                controller.prescriptionFileName.value,
                style: const TextStyle(fontSize: 12),
              )),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Terms & Condition Checkbox
              const TTermsAndConditionCheckBox(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(TTexts.createAccount),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
