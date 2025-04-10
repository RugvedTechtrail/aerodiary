import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/snack_bar.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constTextField.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        centerTitle: true,
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
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button with "Add Patient History" text
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_left,
                      color: ConstColors.primary,
                      size: 35.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text('Add Patient History',
                        style: getTextTheme(color: ConstColors.primary)
                            .headlineMedium),
                  ],
                ),
              ),
              // const SizedBox(height: 24),
              // // Progress indicator
              // Obx(() => LinearProgressIndicator(
              //       value: (controller.currentPageIndex.value + 1) /
              //           controller.totalPages,
              //       backgroundColor: Colors.grey[200],
              //       valueColor:
              //           const AlwaysStoppedAnimation<Color>(Color(0xFF4BA8A5)),
              //     )),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: Obx(() => Text(
              //         'Step ${controller.getCurrentPageNumber()} of ${controller.totalPages}',
              //         style: TextStyle(
              //           color: Colors.grey[600],
              //           fontSize: 14,
              //         ),
              //       )),
              // ),
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

  Widget _buildConditionItem(PatientHistoryController controller, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
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
            SizedBox(width: 10.w),
            Obx(() {
              final condition = controller.conditions[index];
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      condition.name,
                      style: getTextTheme(
                        color: ConstColors.darkGrey,
                      ).bodyMedium,
                    ),
                    if (condition.isSelected.value)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: condition.conditionFromDate.value != null &&
                                condition.dateConfirmed.value
                            ? Text(
                                'Since: ${controller.dateFormat.format(condition.conditionFromDate.value!)}',
                                style: getTextTheme(
                                  color: ConstColors.darkGrey.withOpacity(0.7),
                                  fontSize: 12.sp,
                                ).bodySmall,
                              )
                            : Text(
                                'Select date',
                                style: getTextTheme(
                                  color: ConstColors.grey,
                                  fontSize: 12.sp,
                                ).bodySmall,
                              ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionsPage(PatientHistoryController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header section with green background
          Container(
            decoration: const BoxDecoration(
              color: ConstColors.buttonColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Respiratory Diseases',
                      style: getTextTheme().bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(
              //vertical: 20.h,
              bottom: 20.h,
              left: 10.w,
              right: 10.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
              ),
              color: ConstColors.grey.withOpacity(0.3),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                  child: Text(
                    'Please choose one or more respiratory diseases you are currently having.',
                    style: getTextTheme(
                      color: ConstColors.darkGrey,
                    ).bodyMedium,
                  ),
                ),

                // List of conditions
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
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
                              ? ConstTextField(
                                  customText: 'Please specify',
                                  hintStyle: GoogleFonts.content(
                                    fontWeight: FontWeight.w400,
                                    color: ConstColors.grey,
                                    fontSize: 16.sp,
                                  ),
                                  textStyle: GoogleFonts.content(
                                    fontWeight: FontWeight.w400,
                                    color: ConstColors.darkGrey,
                                    fontSize: 16.sp,
                                  ),
                                  controller:
                                      controller.otherConditionController.value,
                                  validator: controller.validateOther,
                                  keyoardType: TextInputType.text,
                                  inputFormatters: [],
                                  onChanged: (value) {
                                    controller.otherConditionController.value
                                        .text = value;
                                    // controller.formKey.currentState
                                    //     ?.validate(); // Validate on change
                                    controller.update(["login"]);
                                  },
                                  onSaved: (p0) {
                                    controller.updateOther(p0 ?? '');
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                )
                              : const SizedBox.shrink();
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          ConstantButton(
            height: 45.h,
            horiPadding: 15.w,
            vertiPadding: 40.h,
            press: () {
              controller.goToNextPage();
            },
            text: "Next",
            borderRadius: 8.sp,
            color: ConstColors.buttonColor,
            bordercolor: ConstColors.buttonColor,
            style: getTextTheme(
              fontWeight: FontWeight.w500,
            ).bodyMedium,
          )
        ],
      ),
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
        return SizedBox();
      //_buildDefaultBlankPage(controller, pageIndex, headerColor);
    }
  }

  // Medication Information page
  Widget _buildMedicationPage(
      PatientHistoryController controller, Color headerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section with blue background
        // Container(
        //   decoration: BoxDecoration(
        //     color: headerColor,
        //     borderRadius: const BorderRadius.only(
        //       topLeft: Radius.circular(12),
        //       topRight: Radius.circular(12),
        //     ),
        //   ),
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //   child: const Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       // Left side - Icon and text
        //       Row(
        //         children: [
        //           Icon(
        //             Icons.medication,
        //             color: Colors.white,
        //             size: 24,
        //           ),
        //           SizedBox(width: 12),
        //           Text(
        //             'Medication Information',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 16,
        //               fontWeight: FontWeight.w500,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        // // Instructions text
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Text(
        //     'Please enter information about your current medications.',
        //     style: TextStyle(
        //       color: Colors.grey[600],
        //       fontSize: 14,
        //     ),
        //   ),
        // ),
        // // Medication form content
        // Expanded(
        //   child: SingleChildScrollView(
        //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         _buildFormField('Medication Name', 'Enter medication name'),
        //         const SizedBox(height: 16),
        //         _buildFormField('Dosage', 'Enter dosage (e.g., 500mg)'),
        //         const SizedBox(height: 16),
        //         _buildFormField('Frequency', 'How often? (e.g., twice daily)'),
        //         const SizedBox(height: 16),
        //         Text(
        //           'Duration of Treatment',
        //           style: TextStyle(
        //             fontSize: 16,
        //             color: Colors.grey[700],
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //         const SizedBox(height: 8),
        //         // Duration options
        //         Wrap(
        //           spacing: 8.0,
        //           children: [
        //             _buildChip('Less than a week', headerColor),
        //             _buildChip('1-4 weeks', headerColor),
        //             _buildChip('1-6 months', headerColor),
        //             _buildChip('More than 6 months', headerColor),
        //           ],
        //         ),
        //         const SizedBox(height: 24),
        //         Text(
        //           'Side Effects',
        //           style: TextStyle(
        //             fontSize: 16,
        //             color: Colors.grey[700],
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //         const SizedBox(height: 8),
        //         _buildFormField(
        //             'Side Effects', 'List any side effects experienced',
        //             maxLines: 3),
        //       ],
        //     ),
        //   ),
        // ),
        // // Navigation buttons
        // _buildNavigationButtons(controller, false, headerColor),
        Container(
          decoration: BoxDecoration(
            color: ConstColors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.sp),
              topRight: Radius.circular(12.sp),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 16.w,
                        height: 16.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Medication',
                    style: getTextTheme().bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),

        Container(
          // padding: EdgeInsets.symmetric(
          //   //vertical: 20.h,
          //   horizontal: 20.h,
          //   vertical: 10.w,
          // ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.sp),
              bottomRight: Radius.circular(10.sp),
            ),
            color: ConstColors.grey.withOpacity(0.3),
          ),
          child: Column(
            children: [
              // Light gray container for all medication sections
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    // Maintenance Medication section
                    MedicationSection(
                      title: 'Maintenance Medication',
                      placeholder: 'Drug name 1',
                      controller: controller,
                    ),

                    const SizedBox(height: 16),

                    // Rescue Medication section
                    MedicationSection(
                      title: 'Rescue Medication',
                      placeholder: 'Drug name 1',
                      controller: controller,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ConstantButton(
          height: 45.h,
          horiPadding: 15.w,
          vertiPadding: 40.h,
          press: () {
            controller.goToNextPage();
          },
          text: "Next",
          borderRadius: 8.sp,
          color: ConstColors.buttonColor,
          bordercolor: ConstColors.buttonColor,
          style: getTextTheme(
            fontWeight: FontWeight.w500,
          ).bodyMedium,
        ),
        ConstantButton(
          height: 45.h,
          horiPadding: 15.w,
          press: () {
            controller.goToPreviousPage();
          },
          text: "Back",
          borderRadius: 8.sp,
          color: ConstColors.buttonColor,
          bordercolor: ConstColors.buttonColor,
          style: getTextTheme(
            fontWeight: FontWeight.w500,
          ).bodyMedium,
        )
      ],
    );
  }

  // Symptom Severity page with purple theme
  Widget _buildSymptomSeverityPage(
      PatientHistoryController controller, Color headerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                    'dfgsdgsdg',
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
            color: Colors.black,
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
              isSummary ? 'Done' : 'Next',
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
}

class MedicationSection extends StatelessWidget {
  final String title;
  final String placeholder;
  final PatientHistoryController controller;

  const MedicationSection({
    Key? key,
    required this.title,
    required this.placeholder,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: ConstColors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: getTextTheme(
                  color: ConstColors.darkGrey,
                ).bodyMedium,
              ),
              InkWell(
                onTap: () {
                  CustomDialog.showDiaog(controller);
                },
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: ConstColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16.sp,
                    color: ConstColors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: ConstColors.white,
              // border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Text(
              placeholder,
              style: const TextStyle(
                color: Colors.black38,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
