import 'package:aerodiary/View/Screens/Test_Screen/Controller/test_controller.dart';
import 'package:get/get.dart';

class TestScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestScreenController>(
      () => TestScreenController(),
    );
  }
}
