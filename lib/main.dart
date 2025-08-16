import 'package:body_checkup/repository/authendication/authendication_repository.dart';
import 'package:body_checkup/routes/app_pages.dart';
import 'package:body_checkup/routes/app_routes.dart';
import 'package:body_checkup/utils/helpers/path_provider.dart';
import 'package:body_checkup/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bindings/general_binding.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) =>Get.put(AuthendicationRepository()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      initialBinding: GeneralBinding(),
      initialRoute: AppPages.splash,
      getPages: AppRoutes.routes,
      theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
    );
  }
}
