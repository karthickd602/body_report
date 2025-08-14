import 'package:body_checkup/common/widget/app_bar/appbar.dart';

import '../../utils/helpers/path_provider.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(appBar: TAppBar(title: 'Profile Page',),);
  }
}
