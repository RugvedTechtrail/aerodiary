import 'package:aerodiary/View/Screens/Resistration_Page/Controller/registration_controller.dart';
import 'package:get/get.dart';

class ResistrationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}
