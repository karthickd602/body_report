import 'package:body_checkup/common/widget/app_bar/appbar.dart';

import '../../utils/helpers/path_provider.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(appBar: TAppBar(title: 'Dashboard Page',),);
  }
}
