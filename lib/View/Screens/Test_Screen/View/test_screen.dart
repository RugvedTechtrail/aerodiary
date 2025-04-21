import 'package:aerodiary/View/Screens/Dashboard_Page/View/dashBoard_Page.dart';
import 'package:aerodiary/View/Screens/Test_Screen/Controller/test_controller.dart';
import 'package:aerodiary/View/Screens/Test_Screen/Widgets/option_selector.dart';
import 'package:aerodiary/View/Screens/Test_Screen/Widgets/question_container.dart';
import 'package:aerodiary/View/Screens/Test_Screen/Widgets/rescue_frequency_dialog.dart';
import 'package:aerodiary/View/Screens/Test_Screen/Widgets/symptom_severity_dialog.dart';
import 'package:aerodiary/View/Screens/Test_Screen/Widgets/trigger_selector_dialog.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Force a fresh controller instance every time this screen is shown
    // This ensures all selections are reset
    final controller = Get.put(TestScreenController(),
        tag: 'test_screen_controller', permanent: false);

    // Explicitly reset all selections when screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetAllSelections();
    });

    return Scaffold(
      backgroundColor: ConstColors.primary,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () async {
            await GetStorage().erase();
            Get.toNamed('/starting_screen');
          },
          icon: Icon(
            Icons.settings,
            color: ConstColors.darkGrey.withOpacity(0.6),
            size: 30.sp,
          ),
        ),
        title: Text(
          'AeroDiary',
          style: getTextTheme(fontWeight: FontWeight.normal).headlineLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: ConstColors.darkGrey.withOpacity(0.6),
              size: 30.sp,
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
        backgroundColor: ConstColors.primary,
        elevation: 0,
      ),
      body: SafeArea(
        child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Question 1: Did you experience asthma symptoms today?
            _buildQuestion1(controller),

            // Question 2: Did you encounter any known triggers today?
            _buildQuestion2(controller),

            // Question 3: Did you take all doses of your prescribed medication today?
            _buildQuestion3(controller),

            // Question 4: Did you need to use your rescue inhaler today?
            _buildQuestion4(controller),

            // Question 5: Did your symptoms affect your ability to perform daily activities today?
            _buildQuestion5(controller),

            // Question 6: Did you wake up due to your symptoms during the previous night?
            _buildQuestion6(controller),
          ],
        ),
      ),
    );
  }

  // Question 1: Did you experience asthma symptoms today?
  Widget _buildQuestion1(TestScreenController controller) {
    return QuestionContainer(
      questionNumber: '1',
      totalQuestions: controller.totalQuestions,
      questionText: 'How often did you experience asthma symptoms today ?',
      onNext: () => controller.nextQuestion(),
      onBack: null, // First question, so no back functionality
      optionsWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => OptionSelector(
                isSelected: controller.isOption1Selected(0),
                optionText: 'Yes',
                onTap: () {
                  controller.setSymptomsSelection("Yes");
                  Get.dialog(
                    Dialog(
                      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SymptomSeverityDialog(controller: controller),
                    ),
                  );
                },
              )),
          Obx(() => OptionSelector(
                isSelected: controller.isOption2Selected(0),
                optionText: 'No',
                onTap: () => controller.setSymptomsSelection("No"),
              )),
        ],
      ),
    );
  }

  // Question 2: Did you encounter any known triggers today?
  Widget _buildQuestion2(TestScreenController controller) {
    return QuestionContainer(
      questionNumber: '2',
      totalQuestions: controller.totalQuestions,
      questionText: 'Did you encounter any known triggers today?',
      onNext: () => controller.nextQuestion(),
      onBack: controller.previousQuestion,
      optionsWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => OptionSelector(
                isSelected: controller.isOption1Selected(1),
                optionText: 'Yes',
                onTap: () {
                  controller.setTriggersSelection("Yes");
                  Get.dialog(
                    Dialog(
                      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TriggerSelectorDialog(controller: controller),
                    ),
                  );
                },
              )),
          Obx(() => OptionSelector(
                isSelected: controller.isOption2Selected(1),
                optionText: 'No',
                onTap: () => controller.setTriggersSelection("No"),
              )),
        ],
      ),
    );
  }

  // Question 3: Did you take all doses of your prescribed medication today?
  Widget _buildQuestion3(TestScreenController controller) {
    return QuestionContainer(
      questionNumber: '3',
      totalQuestions: controller.totalQuestions,
      questionText:
          'Did you take all doses of your prescribed medication today ?',
      onNext: () => controller.nextQuestion(),
      onBack: controller.previousQuestion,
      optionsWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => OptionSelector(
                isSelected: controller.medicationAnswer.value == 'Yes',
                optionText: 'Yes',
                onTap: () => controller.setMedicationAnswer('Yes'),
              )),
          Obx(() => OptionSelector(
                isSelected:
                    controller.medicationAnswer.value == 'No, I missed 1 dose',
                optionText: 'No, I missed 1 dose',
                onTap: () =>
                    controller.setMedicationAnswer('No, I missed 1 dose'),
              )),
          Obx(() => OptionSelector(
                isSelected: controller.medicationAnswer.value ==
                    'No, I missed multiple doses',
                optionText: 'No, I missed multiple doses',
                onTap: () => controller
                    .setMedicationAnswer('No, I missed multiple doses'),
              )),
        ],
      ),
    );
  }

  // Question 4: Did you need to use your rescue inhaler today?
  Widget _buildQuestion4(TestScreenController controller) {
    return QuestionContainer(
      questionNumber: '4',
      totalQuestions: controller.totalQuestions,
      questionText:
          'Did you need to use your rescue inhaler, or any other quick-relief medication today?',
      onNext: () => controller.nextQuestion(),
      onBack: controller.previousQuestion,
      optionsWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => OptionSelector(
                isSelected: controller.isOption1Selected(3),
                optionText: 'Yes',
                onTap: () {
                  controller.setRescueInhalerSelection("Yes");
                  Get.dialog(
                    Dialog(
                      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: RescueFrequencyDialog(controller: controller),
                    ),
                  );
                },
              )),
          Obx(() => OptionSelector(
                isSelected: controller.isOption2Selected(3),
                optionText: 'No',
                onTap: () => controller.setRescueInhalerSelection("No"),
              )),
        ],
      ),
    );
  }

  // Question 5: Did your symptoms affect your ability to perform daily activities?
  Widget _buildQuestion5(TestScreenController controller) {
    return QuestionContainer(
      questionNumber: '5',
      totalQuestions: controller.totalQuestions,
      questionText:
          'Did your symptoms affect your ability to perform daily activities today ?',
      onNext: () => controller.nextQuestion(),
      onBack: controller.previousQuestion,
      optionsWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => OptionSelector(
                isSelected: controller.isOption1Selected(4),
                optionText: 'Yes',
                onTap: () => controller.setActivitiesSelection("Yes"),
              )),
          Obx(() => OptionSelector(
                isSelected: controller.isOption2Selected(4),
                optionText: 'No',
                onTap: () => controller.setActivitiesSelection("No"),
              )),
        ],
      ),
    );
  }

  // Question 6: Did you wake up due to your symptoms during the previous night?
  Widget _buildQuestion6(TestScreenController controller) {
    return QuestionContainer(
      questionNumber: '6',
      totalQuestions: controller.totalQuestions,
      questionText:
          'Did you wake up due to your symptoms during the previous night ?',
      onNext: () => controller.finalizeQuestionnaire(),
      onBack: controller.previousQuestion,
      isLastQuestion: true,
      optionsWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => OptionSelector(
                isSelected: controller.isOption1Selected(5),
                optionText: 'Yes',
                onTap: () => controller.setWakeUpSelection("Yes"),
              )),
          Obx(() => OptionSelector(
                isSelected: controller.isOption2Selected(5),
                optionText: 'No',
                onTap: () => controller.setWakeUpSelection("No"),
              )),
        ],
      ),
    );
  }
}
