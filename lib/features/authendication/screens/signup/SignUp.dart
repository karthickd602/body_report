import 'package:body_checkup/features/authendication/screens/signup/widget/signup_form.dart';
import 'package:body_checkup/utils/helpers/path_provider.dart';

import '../../../../common/widget/login_signup/form_divder.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Header Tittle

            Text(TTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections,),
          ///Form
             const TSignUpForm(),
            const SizedBox(height: TSizes.spaceBtwSections,),
            ///Divider
            TFormDivder(divdertext: TTexts.orSignUpWith.capitalize!),
            const SizedBox(height: TSizes.spaceBtwSections,),


          ],
        ),),
      )

    );
  }
}
