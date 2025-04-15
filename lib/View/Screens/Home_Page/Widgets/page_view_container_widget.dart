import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/blank_page_widget.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/conditions_page_widget.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/medication_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewContainerWidget extends StatelessWidget {
  final PatientHistoryController controller;

  const PageViewContainerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swiping
        children: [
          // First page - Conditions selection
          GetBuilder<PatientHistoryController>(
            id: 'page_container',
            builder: (_) => ConditionsPageWidget(controller: controller),
          ),

          // Second page - Medication page
          GetBuilder<PatientHistoryController>(
            id: 'page_container',
            builder: (_) => MedicationPageWidget(controller: controller),
          ),

          // Third page - Blank container
          GetBuilder<PatientHistoryController>(
            id: 'page_container',
            builder: (_) => BlankPageWidget(
              controller: controller,
              pageIndex: 2,
            ),
          ),

          // Fourth page - Blank container
          GetBuilder<PatientHistoryController>(
            id: 'page_container',
            builder: (_) => BlankPageWidget(
              controller: controller,
              pageIndex: 3,
            ),
          ),

          // Fifth page - Blank container (Summary)
          GetBuilder<PatientHistoryController>(
            id: 'page_container',
            builder: (_) => BlankPageWidget(
              controller: controller,
              pageIndex: 4,
              isSummary: true,
            ),
          ),
        ],
      ),
    );
  }
}
