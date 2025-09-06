import 'package:body_checkup/features/dashboard/step_controller.dart';
import 'package:body_checkup/features/profile/profile_controller.dart';
import 'package:body_checkup/utils/helpers/path_provider.dart';

import 'dashboard_controller.dart';

class DashboardBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => StepController());
    Get.lazyPut(() => ProfileController());
  }
}