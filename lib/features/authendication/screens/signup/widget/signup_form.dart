import 'package:body_checkup/features/authendication/screens/signup/widget/terms_and_condition.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/helpers/path_provider.dart';
import '../../../controller/signup/signup_controller.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
        key: controller.signupFormKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.firstName,
                      validator: (value) => TValidator.validateEmptyField(
                          TTexts.firstName, value),
                      expands: false,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: TTexts.firstName),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          TValidator.validateEmptyField(TTexts.lastName, value),
                      expands: false,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: TTexts.lastName),
                    ),
                  ),
                ],
              ),

              ///username
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.username,
                validator: (value) =>
                    TValidator.validateEmptyField(TTexts.username, value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.username,
                    prefixIcon: Icon(Iconsax.user_edit)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              ///Email
              TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                keyboardType: TextInputType.emailAddress,
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              ///Phone Number
              TextFormField(
                controller: controller.phoneNo,
                validator: (value) => TValidator.validatePhoneNumber(value),
                expands: false,
                buildCounter: (BuildContext context,
                    {required int currentLength,
                    required int? maxLength,
                    required bool isFocused}) {
                  return null; // Return null to hide the counter
                },
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                    labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              ///Password
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) => TValidator.validatePassword(value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye)),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Terms & Condition Checkbox
              const TTermsAndConditionCheckBox(),

              const SizedBox(height: TSizes.spaceBtwSections),

              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.signup(),
                    child: const Text(TTexts.createAccount),
                  )),
            ],
          ),
        ));
  }
}
