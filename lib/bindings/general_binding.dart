

import 'package:body_checkup/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/network/network_manager.dart';

class GeneralBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());
    GetStorage.init();
    TLocalStorage.instance();
  }

}