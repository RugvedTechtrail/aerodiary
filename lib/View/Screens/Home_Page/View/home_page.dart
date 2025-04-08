import 'package:aerodiary/View/Screens/Home_Page/Controller/patient_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('home'),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // Initialize the controller
//     final PatientHistoryController controller =
//         Get.put(PatientHistoryController());
//     return Scaffold(
//       backgroundColor: ConstColors.primary,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'AeroDiary',
//           style: getTextTheme(fontWeight: FontWeight.normal).headlineLarge,
//         ),
//         backgroundColor: ConstColors.primary,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.sp),
//             color: ConstColors.white,
//           ),
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back Button with "Add Patient History" text
//               Row(
//                 children: [
//                   Icon(
//                     Icons.arrow_left,
//                     color: ConstColors.primary,
//                     size: 35.sp,
//                   ),
//                   SizedBox(width: 8),
//                   Text('Add Patient History',
//                       style: getTextTheme(color: ConstColors.primary)
//                           .headlineMedium),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               // Main Content with PageView for sliding animation
//               Expanded(
//                 child: PageView(
//                   controller: controller.pageController,
//                   physics:
//                       const NeverScrollableScrollPhysics(), // Disable swiping
//                   children: [
//                     // First page - Conditions selection
//                     GetBuilder<PatientHistoryController>(
//                       id: 'page_container',
//                       builder: (_) => _buildConditionsPage(controller),
//                     ),
//                     // Second page - Blank container (can be replaced with next step)
//                     GetBuilder<PatientHistoryController>(
//                       id: 'page_container',
//                       builder: (_) => _buildBlankPage(controller),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildConditionsPage(PatientHistoryController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Header section with green background
//         Container(
//           decoration: const BoxDecoration(
//             color: Color(0xFF0C7872),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12),
//               topRight: Radius.circular(12),
//             ),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Left side - Radio button and text
//               Row(
//                 children: [
//                   Container(
//                     width: 24,
//                     height: 24,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                       child: Container(
//                         width: 16,
//                         height: 16,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Respiratory Diseases',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         // Instructions text
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(
//             'Please choose one or more respiratory diseases you are currently having.',
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//         ),
//         // List of conditions
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: GetBuilder<PatientHistoryController>(
//               id: 'conditions_list',
//               builder: (_) => Column(
//                 children: [
//                   ...List.generate(
//                     controller.conditions.length,
//                     (index) => _buildConditionItem(controller, index),
//                   ),
//                   // Other condition text field (conditionally visible)
//                   Obx(() {
//                     return controller.showOtherTextField.value
//                         ? Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 36.0, right: 16.0, top: 8.0),
//                             child: TextField(
//                               controller: controller.otherConditionController,
//                               decoration: InputDecoration(
//                                 hintText: 'Please specify',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(4.0),
//                                   borderSide:
//                                       BorderSide(color: Colors.grey[300]!),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 8),
//                               ),
//                             ),
//                           )
//                         : const SizedBox.shrink();
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // Next button
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: controller.goToNextPage,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4BA8A5),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Next',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: controller.goToPreviousPage,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4BA8A5),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Back',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   Widget _buildBlankPage(PatientHistoryController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Just a blank white container (same structure as the first page)
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey[200]!),
//             ),
//             child: const Center(
//               child: Text('Next Page Content Will Go Here'),
//             ),
//           ),
//         ),
//         // Next button
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: () {
//               // Handle next action for this page
//               print('Next pressed on second page');
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4BA8A5),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Next',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: controller.goToPreviousPage,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4BA8A5),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Back',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildConditionItem(PatientHistoryController controller, int index) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: InkWell(
//         onTap: () => controller.toggleCondition(index),
//         child: Row(
//           children: [
//             Obx(() {
//               final condition = controller.conditions[index];
//               return Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: condition.isSelected.value
//                         ? const Color(0xFF4BA8A5)
//                         : Colors.grey[400]!,
//                     width: 2,
//                   ),
//                 ),
//                 child: condition.isSelected.value
//                     ? Center(
//                         child: Container(
//                           width: 12,
//                           height: 12,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF4BA8A5),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                       )
//                     : null,
//               );
//             }),
//             const SizedBox(width: 12),
//             Text(
//               controller.conditions[index].name,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Initialize the controller
//     final PatientHistoryController controller =
//         Get.put(PatientHistoryController());

//     return Scaffold(
//       backgroundColor: ConstColors.primary,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'AeroDiary',
//           style: getTextTheme(fontWeight: FontWeight.normal).headlineLarge,
//         ),
//         backgroundColor: ConstColors.primary,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.sp),
//             color: ConstColors.white,
//           ),
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back Button with "Add Patient History" text
//               Row(
//                 children: [
//                   Icon(
//                     Icons.arrow_left,
//                     color: ConstColors.primary,
//                     size: 35.sp,
//                   ),
//                   const SizedBox(width: 8),
//                   Text('Add Patient History',
//                       style: getTextTheme(color: ConstColors.primary)
//                           .headlineMedium),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Progress indicator
//               Obx(() => LinearProgressIndicator(
//                     value: (controller.currentPageIndex.value + 1) /
//                         controller.totalPages,
//                     backgroundColor: Colors.grey[200],
//                     valueColor:
//                         const AlwaysStoppedAnimation<Color>(Color(0xFF4BA8A5)),
//                   )),

//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Obx(() => Text(
//                       'Step ${controller.getCurrentPageNumber()} of ${controller.totalPages}',
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 14,
//                       ),
//                     )),
//               ),

//               // Main Content with PageView for sliding animation
//               Expanded(
//                 child: PageView(
//                   controller: controller.pageController,
//                   physics:
//                       const NeverScrollableScrollPhysics(), // Disable swiping
//                   children: [
//                     // First page - Conditions selection
//                     GetBuilder<PatientHistoryController>(
//                       id: 'page_container',
//                       builder: (_) => _buildConditionsPage(controller),
//                     ),

//                     // Second page - Blank container
//                     GetBuilder<PatientHistoryController>(
//                       id: 'page_container',
//                       builder: (_) => _buildBlankPage(controller, 1),
//                     ),

//                     // Third page - Blank container
//                     GetBuilder<PatientHistoryController>(
//                       id: 'page_container',
//                       builder: (_) => _buildBlankPage(controller, 2),
//                     ),

//                     // Fourth page - Blank container
//                     GetBuilder<PatientHistoryController>(
//                       id: 'page_container',
//                       builder: (_) => _buildBlankPage(controller, 3),
//                     ),

//                     // Fifth page - Blank container (Summary)
//                     GetBuilder<PatientHistoryController>(
//                       id: 'page_container',
//                       builder: (_) =>
//                           _buildBlankPage(controller, 4, isSummary: true),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildConditionsPage(PatientHistoryController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Header section with green background
//         Container(
//           decoration: const BoxDecoration(
//             color: Color(0xFF0C7872),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12),
//               topRight: Radius.circular(12),
//             ),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Left side - Radio button and text
//               Row(
//                 children: [
//                   Container(
//                     width: 24,
//                     height: 24,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                       child: Container(
//                         width: 16,
//                         height: 16,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Respiratory Diseases',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         // Instructions text
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(
//             'Please choose one or more respiratory diseases you are currently having.',
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//         ),

//         // List of conditions
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: GetBuilder<PatientHistoryController>(
//               id: 'conditions_list',
//               builder: (_) => Column(
//                 children: [
//                   ...List.generate(
//                     controller.conditions.length,
//                     (index) => _buildConditionItem(controller, index),
//                   ),

//                   // Other condition text field (conditionally visible)
//                   Obx(() {
//                     return controller.showOtherTextField.value
//                         ? Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 36.0, right: 16.0, top: 8.0),
//                             child: TextField(
//                               controller: controller.otherConditionController,
//                               decoration: InputDecoration(
//                                 hintText: 'Please specify',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(4.0),
//                                   borderSide:
//                                       BorderSide(color: Colors.grey[300]!),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 8),
//                               ),
//                             ),
//                           )
//                         : const SizedBox.shrink();
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         // Next button
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: ElevatedButton(
//             onPressed: controller.goToNextPage,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4BA8A5),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Next',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBlankPage(PatientHistoryController controller, int pageIndex,
//       {bool isSummary = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Header section with green background
//         Container(
//           decoration: const BoxDecoration(
//             color: Color(0xFF0C7872),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12),
//               topRight: Radius.circular(12),
//             ),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Left side - Radio button and text
//               Row(
//                 children: [
//                   Container(
//                     width: 24,
//                     height: 24,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                       child: Container(
//                         width: 16,
//                         height: 16,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Text(
//                     controller.getPageTitle(pageIndex),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         // Instructions text
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(
//             isSummary
//                 ? 'Review your information before submitting.'
//                 : 'Please fill out the information on this page.',
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//         ),

//         // Blank content
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey[200]!),
//             ),
//             margin: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Center(
//               child: Text(
//                 isSummary
//                     ? 'Summary content will go here'
//                     : 'Page ${pageIndex + 1} content will go here',
//                 style: TextStyle(
//                   color: Colors.grey[500],
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//         ),

//         // Navigation buttons
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: ElevatedButton(
//             onPressed: isSummary
//                 ? () {
//                     // Submit form logic would go here
//                     print('Form submitted!');
//                   }
//                 : controller.goToNextPage,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4BA8A5),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text(
//               isSummary ? 'Submit' : 'Next',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: ElevatedButton(
//             onPressed: controller.goToPreviousPage,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.grey[300],
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Back',
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildConditionItem(PatientHistoryController controller, int index) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: InkWell(
//         onTap: () => controller.toggleCondition(index),
//         child: Row(
//           children: [
//             Obx(() {
//               final condition = controller.conditions[index];
//               return Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: condition.isSelected.value
//                         ? const Color(0xFF4BA8A5)
//                         : Colors.grey[400]!,
//                     width: 2,
//                   ),
//                 ),
//                 child: condition.isSelected.value
//                     ? Center(
//                         child: Container(
//                           width: 12,
//                           height: 12,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF4BA8A5),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                       )
//                     : null,
//               );
//             }),
//             const SizedBox(width: 12),
//             Text(
//               controller.conditions[index].name,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final PatientHistoryController controller =
        Get.put(PatientHistoryController());

    return Scaffold(
      backgroundColor: ConstColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'AeroDiary',
          style: getTextTheme(fontWeight: FontWeight.normal).headlineLarge,
        ),
        backgroundColor: ConstColors.primary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: ConstColors.white,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button with "Add Patient History" text
              Row(
                children: [
                  Icon(
                    Icons.arrow_left,
                    color: ConstColors.primary,
                    size: 35.sp,
                  ),
                  const SizedBox(width: 8),
                  Text('Add Patient History',
                      style: getTextTheme(color: ConstColors.primary)
                          .headlineMedium),
                ],
              ),
              const SizedBox(height: 24),

              // Progress indicator
              Obx(() => LinearProgressIndicator(
                    value: (controller.currentPageIndex.value + 1) /
                        controller.totalPages,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF4BA8A5)),
                  )),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(() => Text(
                      'Step ${controller.getCurrentPageNumber()} of ${controller.totalPages}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    )),
              ),

              // Main Content with PageView for sliding animation
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable swiping
                  children: [
                    // First page - Conditions selection
                    GetBuilder<PatientHistoryController>(
                      id: 'page_container',
                      builder: (_) => _buildConditionsPage(controller),
                    ),

                    // Second page - Blank container
                    GetBuilder<PatientHistoryController>(
                      id: 'page_container',
                      builder: (_) => _buildBlankPage(controller, 1),
                    ),

                    // Third page - Blank container
                    GetBuilder<PatientHistoryController>(
                      id: 'page_container',
                      builder: (_) => _buildBlankPage(controller, 2),
                    ),

                    // Fourth page - Blank container
                    GetBuilder<PatientHistoryController>(
                      id: 'page_container',
                      builder: (_) => _buildBlankPage(controller, 3),
                    ),

                    // Fifth page - Blank container (Summary)
                    GetBuilder<PatientHistoryController>(
                      id: 'page_container',
                      builder: (_) =>
                          _buildBlankPage(controller, 4, isSummary: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConditionsPage(PatientHistoryController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section with green background
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0C7872),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Radio button and text
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Respiratory Diseases',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Instructions text
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Please choose one or more respiratory diseases you are currently having.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),

        // List of conditions
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GetBuilder<PatientHistoryController>(
              id: 'conditions_list',
              builder: (_) => Column(
                children: [
                  ...List.generate(
                    controller.conditions.length,
                    (index) => _buildConditionItem(controller, index),
                  ),

                  // Other condition text field (conditionally visible)
                  Obx(() {
                    return controller.showOtherTextField.value
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 36.0, right: 16.0, top: 8.0),
                            child: TextField(
                              controller: controller.otherConditionController,
                              decoration: InputDecoration(
                                hintText: 'Please specify',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ),

        // Next button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: controller.goToNextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4BA8A5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build second page - Medication Information with blue color theme
  Widget _buildBlankPage(PatientHistoryController controller, int pageIndex,
      {bool isSummary = false}) {
    // Different colors for each page
    final List<Color> headerColors = [
      const Color(0xFF0C7872), // Green for first page (already defined)
      const Color(0xFF2C6EB8), // Blue for second page
      const Color(0xFF8E44AD), // Purple for third page
      const Color(0xFFE67E22), // Orange for fourth page
      const Color(0xFF2C3E50), // Dark blue-gray for summary page
    ];

    // Get color for this page
    final Color headerColor = headerColors[pageIndex];

    // Handle different pages
    if (isSummary) {
      return _buildSummaryPage(controller, headerColor);
    }

    switch (pageIndex) {
      case 1:
        return _buildMedicationPage(controller, headerColor);
      case 2:
        return _buildSymptomSeverityPage(controller, headerColor);
      case 3:
        return _buildLifestyleFactorsPage(controller, headerColor);
      default:
        return _buildDefaultBlankPage(controller, pageIndex, headerColor);
    }
  }

  // Medication Information page
  Widget _buildMedicationPage(
      PatientHistoryController controller, Color headerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section with blue background
        Container(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Icon and text
              Row(
                children: [
                  Icon(
                    Icons.medication,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Medication Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Instructions text
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Please enter information about your current medications.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),

        // Medication form content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFormField('Medication Name', 'Enter medication name'),
                const SizedBox(height: 16),
                _buildFormField('Dosage', 'Enter dosage (e.g., 500mg)'),
                const SizedBox(height: 16),
                _buildFormField('Frequency', 'How often? (e.g., twice daily)'),
                const SizedBox(height: 16),

                Text(
                  'Duration of Treatment',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                // Duration options
                Wrap(
                  spacing: 8.0,
                  children: [
                    _buildChip('Less than a week', headerColor),
                    _buildChip('1-4 weeks', headerColor),
                    _buildChip('1-6 months', headerColor),
                    _buildChip('More than 6 months', headerColor),
                  ],
                ),

                const SizedBox(height: 24),
                Text(
                  'Side Effects',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFormField(
                    'Side Effects', 'List any side effects experienced',
                    maxLines: 3),
              ],
            ),
          ),
        ),

        // Navigation buttons
        _buildNavigationButtons(controller, false, headerColor),
      ],
    );
  }

  // Symptom Severity page with purple theme
  Widget _buildSymptomSeverityPage(
      PatientHistoryController controller, Color headerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section with purple background
        Container(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Icon and text
              Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Symptom Severity',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Instructions text
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Please rate the severity of your symptoms on a scale of 1-10.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),

        // Symptom severity form
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSeveritySlider('Shortness of Breath', headerColor),
                const SizedBox(height: 16),
                _buildSeveritySlider('Coughing', headerColor),
                const SizedBox(height: 16),
                _buildSeveritySlider('Chest Pain', headerColor),
                const SizedBox(height: 16),
                _buildSeveritySlider('Wheezing', headerColor),
                const SizedBox(height: 16),
                _buildSeveritySlider('Fatigue', headerColor),
                const SizedBox(height: 24),
                Text(
                  'Additional Symptoms',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFormField('Other Symptoms', 'Describe any other symptoms',
                    maxLines: 3),
              ],
            ),
          ),
        ),

        // Navigation buttons
        _buildNavigationButtons(controller, false, headerColor),
      ],
    );
  }

  // Lifestyle Factors page with orange theme
  Widget _buildLifestyleFactorsPage(
      PatientHistoryController controller, Color headerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section with orange background
        Container(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Icon and text
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Lifestyle Factors',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Instructions text
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Please provide information about your lifestyle factors.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),

        // Lifestyle factors form
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smoking Status',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: [
                    _buildChip('Never smoked', headerColor),
                    _buildChip('Former smoker', headerColor),
                    _buildChip('Current smoker', headerColor),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Exercise Frequency',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: [
                    _buildChip('None', headerColor),
                    _buildChip('1-2 times/week', headerColor),
                    _buildChip('3-5 times/week', headerColor),
                    _buildChip('Daily', headerColor),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Diet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: [
                    _buildChip('Vegetarian', headerColor),
                    _buildChip('Vegan', headerColor),
                    _buildChip('Mediterranean', headerColor),
                    _buildChip('Standard', headerColor),
                    _buildChip('Other', headerColor),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Allergens or Triggers',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFormField('Allergens/Triggers',
                    'List any known allergens or triggers',
                    maxLines: 3),
              ],
            ),
          ),
        ),

        // Navigation buttons
        _buildNavigationButtons(controller, false, headerColor),
      ],
    );
  }

  // Summary page with dark blue-gray theme
  Widget _buildSummaryPage(
      PatientHistoryController controller, Color headerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section with dark blue-gray background
        Container(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Icon and text
              Row(
                children: [
                  Icon(
                    Icons.summarize,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Instructions text
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Please review your information before submitting.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),

        // Summary content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummarySection(
                    'Selected Conditions',
                    [
                      'The conditions you selected will be listed here',
                      'Example: Condition 1, Condition 3',
                    ],
                    const Color(0xFF0C7872)),
                const SizedBox(height: 16),
                _buildSummarySection(
                    'Medication Information',
                    [
                      'Your medication details will be summarized here',
                      'Example: Medication X - 500mg twice daily',
                    ],
                    const Color(0xFF2C6EB8)),
                const SizedBox(height: 16),
                _buildSummarySection(
                    'Symptom Severity',
                    [
                      'Your symptom ratings will be displayed here',
                      'Example: Shortness of Breath - 7/10',
                    ],
                    const Color(0xFF8E44AD)),
                const SizedBox(height: 16),
                _buildSummarySection(
                    'Lifestyle Factors',
                    [
                      'Your lifestyle information will be shown here',
                      'Example: Former smoker, Exercise 3-5 times/week',
                    ],
                    const Color(0xFFE67E22)),
              ],
            ),
          ),
        ),

        // Navigation buttons with Submit instead of Next
        _buildNavigationButtons(controller, true, headerColor),
      ],
    );
  }

  // Default blank page as a fallback
  Widget _buildDefaultBlankPage(
      PatientHistoryController controller, int pageIndex, Color headerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section
        Container(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Icon and text
              Row(
                children: [
                  const Icon(
                    Icons.article,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    controller.getPageTitle(pageIndex),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Instructions text
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Please fill out the information on this page.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),

        // Blank content
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Page ${pageIndex + 1} content will go here',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),

        // Navigation buttons
        _buildNavigationButtons(controller, false, headerColor),
      ],
    );
  }

  // Helper widgets
  Widget _buildFormField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return FilterChip(
      label: Text(label),
      backgroundColor: Colors.grey[200],
      selectedColor: color.withOpacity(0.2),
      checkmarkColor: color,
      onSelected: (bool selected) {
        // In a real app, you'd handle selection
        print('$label selected: $selected');
      },
      labelStyle: TextStyle(color: Colors.grey[800]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildSeveritySlider(String symptomName, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          symptomName,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Text('0', style: TextStyle(color: Colors.grey[600])),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: accentColor,
                  thumbColor: accentColor,
                  inactiveTrackColor: Colors.grey[300],
                ),
                child: Slider(
                  min: 0,
                  max: 10,
                  divisions: 10,
                  value:
                      5, // Default value, in real app this would be from controller
                  onChanged: (value) {
                    // In a real app, you'd handle value changes
                    print('$symptomName severity: $value');
                  },
                ),
              ),
            ),
            Text('10', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildSummarySection(String title, List<String> items, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(
                          '•',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(
      PatientHistoryController controller, bool isSummary, Color accentColor) {
    return Column(
      children: [
        // Next/Submit button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: isSummary
                ? () {
                    // Submit form logic would go here
                    print('Form submitted!');
                  }
                : controller.goToNextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isSummary ? 'Submit' : 'Next',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // Back button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: controller.goToPreviousPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4BA8A5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Back',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConditionItem(PatientHistoryController controller, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => controller.toggleCondition(index),
        child: Row(
          children: [
            Obx(() {
              final condition = controller.conditions[index];
              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: condition.isSelected.value
                        ? const Color(0xFF4BA8A5)
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
                child: condition.isSelected.value
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4BA8A5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              );
            }),
            const SizedBox(width: 12),
            Text(
              controller.conditions[index].name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
