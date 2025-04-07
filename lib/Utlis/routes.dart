import 'package:aerodiary/View/Screens/Dashboard_Page/View/dashBoard_Page.dart';
import 'package:aerodiary/View/Screens/Patient_Screen/Bindings/patient_bindings.dart';
import 'package:aerodiary/View/Screens/Patient_Screen/View/patient_screen.dart';
import 'package:aerodiary/View/Screens/Resistration_Page/Bindings/resistration_bindings.dart';
import 'package:aerodiary/View/Screens/Resistration_Page/View/registration_page.dart';
import 'package:aerodiary/View/Screens/Splash_Screen/splash_screen.dart';
import 'package:aerodiary/View/Screens/Starting_Page/starting_page.dart';
import 'package:aerodiary/View/Screens/Welcome_Page/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

GetStorage box = GetStorage();

class Routes {
  static final pages = [
    GetPage(name: '/splash_screen', page: () => const SplashScreen()),
    GetPage(
      name: '/starting_screen',
      page: () => const StartingPage(),
    ),
    GetPage(
      name: '/welcome_page',
      page: () => const WelcomePage(),
    ),
    GetPage(
        name: '/registration_screen',
        page: () => const RegistrationPage(),
        bindings: [ResistrationBindings()]),
    GetPage(
        name: '/dashboard_screen',
        page: () => const DashboardPage(),
        bindings: [
          // DashBoardBinding(),
          // HomeBinding(),
          // AdminHomeScreenBinding()
        ]),
    GetPage(
        name: '/patient_screen',
        page: () => const PatientScreen(),
        bindings: [PatientBindings()]),
  ];
}
