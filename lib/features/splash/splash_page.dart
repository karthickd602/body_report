import '../../utils/helpers/path_provider.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Text("Body Report App")
            // Center(
            //   child: Image.asset(
            //     THelperFunctions.isDarkMode(context)
            //         ? TImages.appLogoDark
            //         : TImages.appLogoLight,
            //     width: 250,
            //     height: 180,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
