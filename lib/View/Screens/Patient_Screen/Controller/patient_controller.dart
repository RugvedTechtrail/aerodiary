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

  void validateSpecificField(String fieldName) {
    // This method uses AutovalidateMode.disabled, so we need to manually trigger validation
    // for the specific field by using field-specific controllers

    // Create a validator map that connects field names to their validation functions
    final validators = {
      'firstName': () => validateFirstName(firstNameController.value.text),
      'lastName': () => validateLastName(lastNameControllerNew.value.text),
      'dob': () => validateDateOfBirth(dateOfBirthController.value.text),
      'gender': () => validateGender(gender.value),
      'email': () => validateEmail(emailController.value.text),
      'mobile': () => validateMobile(mobileNumberController.value.text),
      'otp': () => validateOTP(otpControllerNew.value.text),
    };

    // Only validate the specified field and update the form
    if (validators.containsKey(fieldName)) {
      validators[fieldName]!();
    }

    // We're not calling formKey.currentState?.validate() here
    // as that would validate all fields
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    } else if (value.length < 3) {
      return 'First name must be at least 3 characters';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (value == "" || value == null || value.isEmpty) {
      return 'Date of birth is required';
    }
    // If we reach here, the date is valid
    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Gender is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  String? validateOTP(String? value) {
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
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      isLoading.value = false;

      update(["login"]);
      Get.toNamed('/dashboard_screen');
      //Get.snackbar("Login", "Login Successful");
    });
  }
}
