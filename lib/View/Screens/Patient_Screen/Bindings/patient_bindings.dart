import 'package:aerodiary/View/Screens/Patient_Screen/Controller/patient_controller.dart';
import 'package:aerodiary/View/Screens/Resistration_Page/Controller/registration_controller.dart';
import 'package:get/get.dart';

class PatientBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientController>(
      () => PatientController(),
    );
  }
}
