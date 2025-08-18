import 'package:body_checkup/utils/helpers/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardController extends GetxController{

  Future<void> _callEmergency(String number) async {
    final Uri uri = Uri(scheme: "tel", path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not call $number");
    }
  }

}