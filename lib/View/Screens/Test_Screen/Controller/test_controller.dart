import 'dart:developer';

import 'package:aerodiary/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreenController extends GetxController {
  // PageView Controller
  late PageController pageController;

  // Current page index
  final RxInt currentQuestionIndex = 0.obs;

  // Total number of questions
  final int totalQuestions = 6;

  // Question 1: Did you experience asthma symptoms?
  final Rx<String?> symptomsSelection = Rx<String?>(null);
  final RxString symptomsAnswer = RxString("");

  // Question 2: Did you encounter triggers?
  final Rx<String?> triggersSelection = Rx<String?>(null);
  final RxString triggersAnswer = RxString("");
  final RxList<String> selectedTriggers = <String>[].obs;
  final RxString otherTrigger = RxString("");

  // Question 3: Did you take medication?
  final RxString medicationAnswer = RxString("");

  // Question 4: Did you use rescue inhaler?
  final Rx<String?> rescueInhalerSelection = Rx<String?>(null);
  final RxString rescueInhalerAnswer = RxString("");

  // Question 5: Did symptoms affect daily activities?
  final Rx<String?> activitiesSelection = Rx<String?>(null);
  final RxString activitiesAnswer = RxString("");

  // Question 6: Did you wake up due to symptoms?
  final Rx<String?> wakeUpSelection = Rx<String?>(null);
  final RxString wakeUpAnswer = RxString("");

  // Symptom severity levels - initialized with empty values
  final RxMap<String, String> symptomSeverity = {
    'Coughing': '',
    'Wheezing': '',
    'Congestion': '',
    'Breathlessness': '',
  }.obs;

  // Flag to track if symptom severities have been set
  final RxBool symptomSeverityComplete = RxBool(false);

  // List of possible triggers
  final List<String> triggersList = [
    'Allergens (dust, pollen, pet dander, etc.)',
    'Pollution',
    'Cigarette Smoke',
    'Physical Activity / Exercise',
    'Weather',
    'Stress',
    'Emotional state',
    'Others'
  ];

  // List of rescue inhaler frequency options
  final List<String> rescueFrequency = [
    'Once',
    'Twice',
    'More than 2 times today'
  ];

  // Combined answers for summary
  final RxMap<String, dynamic> allAnswers = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    resetAllSelections();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // Reset all selections
  void resetAllSelections() {
    symptomsSelection.value = null;
    symptomsAnswer.value = "";

    triggersSelection.value = null;
    triggersAnswer.value = "";
    selectedTriggers.clear();
    otherTrigger.value = "";

    medicationAnswer.value = "";

    rescueInhalerSelection.value = null;
    rescueInhalerAnswer.value = "";

    activitiesSelection.value = null;
    activitiesAnswer.value = "";

    wakeUpSelection.value = null;
    wakeUpAnswer.value = "";

    symptomSeverity.value = {
      'Coughing': '',
      'Wheezing': '',
      'Congestion': '',
      'Breathlessness': '',
    };

    symptomSeverityComplete.value = false;

    allAnswers.clear();

    currentQuestionIndex.value = 0;

    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
  }

  // Method to move to the next question
  void nextQuestion() {
    // Save the current question's answer
    saveCurrentAnswer();

    if (currentQuestionIndex.value < totalQuestions - 1) {
      currentQuestionIndex.value++;
      pageController.animateToPage(
        currentQuestionIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Log the selected answers
      logCurrentAnswers();
    } else {
      // If it's the last question, finalize and submit
      finalizeQuestionnaire();
    }
  }

  // Method to go back to the previous question
  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
      pageController.animateToPage(
        currentQuestionIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Log the current answers
      logCurrentAnswers();
    }
  }

  // Method to save the current question's answer
  void saveCurrentAnswer() {
    switch (currentQuestionIndex.value) {
      case 0:
        symptomsAnswer.value = symptomsSelection.value == "Yes" ? "Yes" : "No";
        allAnswers['experiencedSymptoms'] = symptomsAnswer.value;
        break;
      case 1:
        triggersAnswer.value = triggersSelection.value == "Yes" ? "Yes" : "No";
        allAnswers['encounteredTriggers'] = triggersAnswer.value;
        allAnswers['selectedTriggers'] = selectedTriggers;
        allAnswers['otherTrigger'] = otherTrigger.value;
        break;
      case 2:
        allAnswers['medicationAnswer'] = medicationAnswer.value;
        break;
      case 3:
        rescueInhalerAnswer.value =
            rescueInhalerSelection.value == "Yes" ? "Yes" : "No";
        allAnswers['usedRescueInhaler'] = rescueInhalerAnswer.value;
        break;
      case 4:
        activitiesAnswer.value =
            activitiesSelection.value == "Yes" ? "Yes" : "No";
        allAnswers['symptomsAffectedActivities'] = activitiesAnswer.value;
        break;
      case 5:
        wakeUpAnswer.value = wakeUpSelection.value == "Yes" ? "Yes" : "No";
        allAnswers['wokeUpDueToSymptoms'] = wakeUpAnswer.value;
        break;
    }
  }

  // Method to log current answers
  void logCurrentAnswers() {
    log('Current Question: ${currentQuestionIndex.value + 1}');
    log('All Answers: $allAnswers');

    switch (currentQuestionIndex.value) {
      case 0:
        log('Experienced Symptoms: ${symptomsAnswer.value}');
        if (symptomsSelection.value == "Yes" && symptomSeverityComplete.value) {
          log('Symptom Severity: ${symptomSeverity.toString()}');
        }
        break;
      case 1:
        log('Encountered Triggers: ${triggersAnswer.value}');
        if (triggersSelection.value == "Yes") {
          log('Selected Triggers: ${selectedTriggers.toString()}');
          if (selectedTriggers.contains('Others')) {
            log('Other Trigger: ${otherTrigger.value}');
          }
        }
        break;
      case 2:
        log('Medication: ${medicationAnswer.value}');
        break;
      case 3:
        log('Used Rescue Inhaler: ${rescueInhalerAnswer.value}');
        if (rescueInhalerSelection.value == "Yes") {
          log('Rescue Inhaler Frequency: ${rescueInhalerAnswer.value}');
        }
        break;
      case 4:
        log('Symptoms Affected Activities: ${activitiesAnswer.value}');
        break;
      case 5:
        log('Woke Up Due To Symptoms: ${wakeUpAnswer.value}');
        break;
    }
  }

  // Method to finalize the questionnaire
  void finalizeQuestionnaire() {
    // Save all answers to a final object
    allAnswers['symptomSeverity'] = symptomSeverity;

    // Log all the selected answers in a structured format
    log('\n======= QUESTIONNAIRE SUMMARY =======');
    log('Question 1: Did you experience asthma symptoms today?');
    log('Answer: ${symptomsSelection.value ?? "No answer"}');

    if (symptomsSelection.value == "Yes") {
      log('Symptom Severity:');
      symptomSeverity.forEach((symptom, severity) {
        log('  - $symptom: ${severity.isNotEmpty ? severity : "Not selected"}');
      });
    }

    log('\nQuestion 2: Did you encounter any known triggers today?');
    log('Answer: ${triggersSelection.value ?? "No answer"}');

    if (triggersSelection.value == "Yes") {
      log('Selected Triggers:');
      if (selectedTriggers.isEmpty) {
        log('  - None selected');
      } else {
        for (String trigger in selectedTriggers) {
          if (trigger == 'Others') {
            log('  - Others: ${otherTrigger.value}');
          } else {
            log('  - $trigger');
          }
        }
      }
    }

    log('\nQuestion 3: Did you take all doses of your prescribed medication today?');
    log('Answer: ${medicationAnswer.value.isNotEmpty ? medicationAnswer.value : "No answer"}');

    log('\nQuestion 4: Did you need to use your rescue inhaler today?');
    log('Answer: ${rescueInhalerSelection.value ?? "No answer"}');

    if (rescueInhalerSelection.value == "Yes") {
      log('Rescue Inhaler Frequency: ${rescueInhalerAnswer.value.isNotEmpty ? rescueInhalerAnswer.value : "Not specified"}');
    }

    log('\nQuestion 5: Did your symptoms affect your ability to perform daily activities today?');
    log('Answer: ${activitiesSelection.value ?? "No answer"}');

    log('\nQuestion 6: Did you wake up due to your symptoms during the previous night?');
    log('Answer: ${wakeUpSelection.value ?? "No answer"}');

    log('===================================\n');

    // Show a snackbar instead of navigating back
    Get.snackbar(
      'Success',
      'Questionnaire completed successfully!',
      backgroundColor: ConstColors.green.withOpacity(0.7),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );

    // Reset all selections after showing the success message
    Future.delayed(const Duration(milliseconds: 500), () {
      resetAllSelections();
    });
  }

  // Helper methods to check selection
  bool isOption1Selected(int questionIndex) {
    switch (questionIndex) {
      case 0:
        return symptomsSelection.value == "Yes";
      case 1:
        return triggersSelection.value == "Yes";
      case 3:
        return rescueInhalerSelection.value == "Yes";
      case 4:
        return activitiesSelection.value == "Yes";
      case 5:
        return wakeUpSelection.value == "Yes";
      default:
        return false;
    }
  }

  bool isOption2Selected(int questionIndex) {
    switch (questionIndex) {
      case 0:
        return symptomsSelection.value == "No";
      case 1:
        return triggersSelection.value == "No";
      case 3:
        return rescueInhalerSelection.value == "No";
      case 4:
        return activitiesSelection.value == "No";
      case 5:
        return wakeUpSelection.value == "No";
      default:
        return false;
    }
  }

  // Toggle methods with logging
  void setSymptomsSelection(String value) {
    symptomsSelection.value = value;
    log('Question 1: Selected option = $value');
  }

  void setTriggersSelection(String value) {
    triggersSelection.value = value;
    log('Question 2: Selected option = $value');
  }

  void setMedicationAnswer(String value) {
    medicationAnswer.value = value;
    log('Question 3: Selected option = $value');
  }

  void setRescueInhalerSelection(String value) {
    rescueInhalerSelection.value = value;
    log('Question 4: Selected option = $value');
  }

  void setActivitiesSelection(String value) {
    activitiesSelection.value = value;
    log('Question 5: Selected option = $value');
  }

  void setWakeUpSelection(String value) {
    wakeUpSelection.value = value;
    log('Question 6: Selected option = $value');
  }

  void updateSymptomSeverity(String symptom, String severity) {
    symptomSeverity[symptom] = severity;
    log('Symptom Severity: $symptom = $severity');

    // Check if all symptoms have severities selected
    bool allSelected = true;
    symptomSeverity.forEach((key, value) {
      if (value.isEmpty) {
        allSelected = false;
      }
    });

    symptomSeverityComplete.value = allSelected;
  }

  void toggleSelectedTrigger(String trigger, bool isSelected) {
    if (isSelected) {
      selectedTriggers.add(trigger);
      log('Added trigger: $trigger');
    } else {
      selectedTriggers.remove(trigger);
      log('Removed trigger: $trigger');
    }
  }

  void updateOtherTrigger(String value) {
    otherTrigger.value = value;
    log('Updated other trigger: $value');
  }

  void setRescueFrequency(String value) {
    rescueInhalerAnswer.value = value;
    log('Rescue inhaler frequency: $value');
  }

  // Get formatted symptom severity for display
  String getFormattedSymptomSeverity() {
    List<String> formattedSeverities = [];

    symptomSeverity.forEach((symptom, severity) {
      if (severity.isNotEmpty) {
        formattedSeverities.add('$symptom: $severity');
      }
    });

    return formattedSeverities.join(', ');
  }

  // Get formatted triggers for display
  String getFormattedTriggers() {
    List<String> formattedTriggers = [];

    for (String trigger in selectedTriggers) {
      if (trigger == 'Others' && otherTrigger.value.isNotEmpty) {
        formattedTriggers.add('Others: ${otherTrigger.value}');
      } else {
        formattedTriggers.add(trigger);
      }
    }

    return formattedTriggers.join(', ');
  }
}
