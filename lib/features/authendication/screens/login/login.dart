import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/style/spacing_style.dart';
import '../../../../common/widget/login_signup/form_divder.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widget/login_form.dart';
import 'widget/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingwithappbarweight,
          child: Column(
            children: [
              ///logo
              const TLoginHeader(),
              const SizedBox(height: TSizes.sm),

              ///Form
              ///
              const TLoginForm(),

            ],
          ),
        ),
      ),
    );
  }
}
