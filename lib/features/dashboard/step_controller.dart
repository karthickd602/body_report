import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';

class StepController extends GetxController {
  var steps = 0.obs;

  Stream<StepCount>? _stepCountStream;

  @override
  void onInit() {
    super.onInit();
    initStepCount();
  }

  void initStepCount() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream?.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    steps.value = event.steps;
  }

  void onStepCountError(error) {
    steps.value = 0;
  }
}
