// import 'dart:developer';

// import 'package:aerodiary/Utlis/api.dart';
// import 'package:aerodiary/constants/const_colors.dart';
// import 'package:aerodiary/constants/global.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get_storage/get_storage.dart';

// class PatientController extends GetxController {
//   final GetStorage storage = GetStorage();
//   API api = API();
//   Rx<TextEditingController> emailController = TextEditingController().obs;
//   Rx<TextEditingController> firstNameController = TextEditingController().obs;
//   Rx<TextEditingController> lastNameControllerNew = TextEditingController().obs;
//   Rx<TextEditingController> mobileNumberController =
//       TextEditingController().obs;
//   Rx<TextEditingController> otpControllerNew = TextEditingController().obs;
//   final dateOfBirthController = TextEditingController().obs;
//   RxList genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'].obs;
//   final gender = ''.obs;
//   RxBool isObecure = true.obs;
//   RxBool isObsecure1 = true.obs;
//   RxBool isLoading = false.obs;
//   RxString isNew = "".obs;
//   GetStorage box = GetStorage();
//   // List<GetRoleModel> getRoleModel = [];
//   int code = 0;

//   @override
//   void onInit() {
//     super.onInit();
//     emailController.value.clear();
//     firstNameController.value.clear();
//     lastNameControllerNew.value.clear();
//     mobileNumberController.value.clear();
//     otpControllerNew.value.clear();

//     isObecure = true.obs;
//     isLoading = false.obs;
//   }

//   @override
//   void onClose() {
//     emailController.value.clear();
//     firstNameController.value.clear();
//     lastNameControllerNew.value.clear();
//     mobileNumberController.value.clear();
//     otpControllerNew.value.clear();

//     isObecure = true.obs;
//     isLoading = false.obs;
//     super.onClose();
//   }

//   String? validateFirstName(String? value) {
//     update(["login"]);
//     if (value == null || value.isEmpty) {
//       return 'First name is required';
//     }
//     return null;
//   }

//   String? validateLastName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Last name is required';
//     }
//     update(["login"]);
//     return null;
//   }

//   String? validateDateOfBirth(String? value) {
//     update(["login"]);
//     if (value == null || value.isEmpty) {
//       return 'Date of birth is required';
//     }
//     return null;
//   }

//   String? validateGender(String? value) {
//     update(["login"]);
//     if (value == null || value.isEmpty) {
//       return 'Gender is required';
//     }

//     return null;
//   }

//   String? validateEmail(String? value) {
//     update(["login"]);
//     if (value == null || value.isEmpty) {
//       return 'Email is required';
//     }
//     if (!GetUtils.isEmail(value)) {
//       return 'Please enter a valid email';
//     }
//     return null;
//   }

//   String? validateMobile(String? value) {
//     update(["login"]);
//     if (value == null || value.isEmpty) {
//       return 'Mobile number is required';
//     }
//     if (!GetUtils.isPhoneNumber(value)) {
//       return 'Please enter a valid mobile number';
//     }

//     return null;
//   }

//   String? validateOTP(String? value) {
//     update(["login"]);
//     if (value == null || value.isEmpty) {
//       return 'OTP is required';
//     }
//     if (value.length < 4) {
//       return 'OTP must be at least 4 digits';
//     }
//     return null; // Add this
//   }

//   void updateEmail(String value) {
//     emailController.value.text = value;
//     update(["login"]);
//   }

//   void updateMobile(String value) {
//     mobileNumberController.value.text = value;
//     update(["login"]);
//   }

//   void updateFName(String value) {
//     firstNameController.value.text = value;
//     update(["login"]);
//   }

//   void updateLName(String value) {
//     lastNameControllerNew.value.text = value;
//     update(["login"]);
//   }

//   void updateOtp(String value) {
//     otpControllerNew.value.text = value;
//     update(["login"]);
//   }

//   void updateDob(String value) {
//     dateOfBirthController.value.text = value;
//     update(["login"]);
//   }

//   void updateGender(String value) {
//     gender.value = value;
//     update(["login"]);
//   }
// }
import 'dart:developer';

import 'package:aerodiary/Utlis/api.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';

class PatientController extends GetxController {
  final GetStorage storage = GetStorage();
  API api = API();
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // Add formKey here
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameControllerNew = TextEditingController().obs;
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> otpControllerNew = TextEditingController().obs;
  final dateOfBirthController = TextEditingController().obs;
  RxList genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'].obs;
  final gender = ''.obs;
  RxBool isObecure = true.obs;
  RxBool isObsecure1 = true.obs;
  RxBool isLoading = false.obs;
  RxString isNew = "".obs;
  GetStorage box = GetStorage();
  // List<GetRoleModel> getRoleModel = [];
  int code = 0;

  @override
  void onInit() {
    super.onInit();
    emailController.value.clear();
    firstNameController.value.clear();
    lastNameControllerNew.value.clear();
    mobileNumberController.value.clear();
    otpControllerNew.value.clear();

    isObecure = true.obs;
    isLoading = false.obs;
  }

  @override
  void onClose() {
    emailController.value.clear();
    firstNameController.value.clear();
    lastNameControllerNew.value.clear();
    mobileNumberController.value.clear();
    otpControllerNew.value.clear();

    isObecure = true.obs;
    isLoading = false.obs;
    super.onClose();
  }

  RxBool isValidating = false.obs;
  RxMap<String, bool> touchedFields = <String, bool>{
    'firstName': false,
    'lastName': false,
    'dob': false,
    'gender': false,
    'email': false,
    'mobile': false,
    'otp': false,
  }.obs;
  RxBool submitAttempted = false.obs;
  void markFieldAsTouched(String fieldName) {
    touchedFields[fieldName] = true;
    update(["login"]);
  }

  void validateSpecificField(String fieldName) {
    // Mark this field as touched so validation errors will show for it
    touchedFields[fieldName] = true;

    // Validators map - functions to validate each specific field
    final validators = {
      'firstName': () => validateFirstName(firstNameController.value.text),
      'lastName': () => validateLastName(lastNameControllerNew.value.text),
      'dob': () => validateDateOfBirth(dateOfBirthController.value.text),
      'gender': () => validateGender(gender.value),
      'email': () => validateEmail(emailController.value.text),
      'mobile': () => validateMobile(mobileNumberController.value.text),
      'otp': () => validateOTP(otpControllerNew.value.text),
    };

    // Run the validator for this specific field
    if (validators.containsKey(fieldName)) {
      // Execute the validator but we don't need to do anything with the result
      // The Form widget will handle showing the validation message
      validators[fieldName]!();
    }

    // Update the UI to reflect the changes - this will rebuild the form
    // with the updated validation state
    update(["login"]);
  }

  String? validateFirstName(String? value) {
    // Only validate if the field was touched or submit was attempted
    if (!touchedFields['firstName']! && !submitAttempted.value) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return 'First name is required';
    } else if (value.length < 3) {
      return 'First name must be at least 3 characters';
    }
    return null;
  }

// Apply similar changes to all other validator methods
// Here's an example for lastName:
  String? validateLastName(String? value) {
    if (!touchedFields['lastName']! && !submitAttempted.value) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (!touchedFields['dob']! && !submitAttempted.value) {
      return null;
    }
    if (value == "" || value == null || value.isEmpty) {
      return 'Date of birth is required';
    }
    // If we reach here, the date is valid
    return null;
  }

  String? validateGender(String? value) {
    if (!touchedFields['gender']! && !submitAttempted.value) {
      return null;
    }
    if (value == null || value.isEmpty) {
      return 'Gender is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (!touchedFields['email']! && !submitAttempted.value) {
      return null;
    }
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (!touchedFields['mobile']! && !submitAttempted.value) {
      return null;
    }
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  String? validateOTP(String? value) {
    if (!touchedFields['otp']! && !submitAttempted.value) {
      return null;
    }
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length < 4) {
      return 'OTP must be at least 4 digits';
    }
    return null;
  }

  void updateEmail(String value) {
    emailController.value.text = value;
    update(["login"]);
  }

  void updateMobile(String value) {
    mobileNumberController.value.text = value;
    update(["login"]);
  }

  void updateFName(String value) {
    firstNameController.value.text = value;
    update(["login"]);
  }

  void updateLName(String value) {
    lastNameControllerNew.value.text = value;
    update(["login"]);
  }

  void updateOtp(String value) {
    otpControllerNew.value.text = value;
    update(["login"]);
  }

  void updateDob(String value) {
    dateOfBirthController.value.text = value;
    update(["login"]);
  }

  void updateGender(String value) {
    gender.value = value;
    update(["login"]);
  }

  void login() {
    submitAttempted.value = true;
    update(["login"]);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 3), () async {
        isLoading.value = false;
        update(["login"]);
        await box.write('authToken', 'authToken');
        Get.toNamed('/dashboard_screen');
      });
    } else {
      Get.snackbar(
        "User Alert !",
        "Please enter all the fields",
        backgroundColor: ConstColors.snack.withOpacity(0.8),
        colorText: ConstColors.white,
        snackStyle: SnackStyle.FLOATING,
        margin: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 8.w,
        ),
      );
    }
  }
}
