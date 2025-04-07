import 'dart:developer';

import 'package:aerodiary/Utlis/api.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegistrationController extends GetxController {
  final GetStorage storage = GetStorage();
  API api = API();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameControllerNew = TextEditingController().obs;
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> otpControllerNew = TextEditingController().obs;

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

    isObecure = true.obs;
    isLoading = false.obs;
  }

  @override
  void onClose() {
    emailController.value.clear();

    isObecure = true.obs;
    isLoading = false.obs;
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      update(["login"]);
      return 'Please enter an user name';
    }
    update(["login"]);
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      update();
      return 'Please enter a password';
    }
    if (value.length < 6) {
      update();
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      update();
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      update();
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      update();
      return 'Password must contain at least one digit';
    }

    if (!RegExp(r'[!@#\$%\^&\*(),.?":{}|<>]').hasMatch(value)) {
      update();
      return 'Password must contain at least one special character';
    }
    update();
    return null;
  }

  void updateEmail(String value) {
    emailController.value.text = value;
    update(["login"]);
  }

  // void updatePassword(String value) {
  //   passwordController.value.text = value;
  //   update([
  //     "login"
  //   ]); // Notify GetBuilder to rebuild the widgets using this controller
  // }

  // void updatePasswordNew(String value) {
  //   passwordControllerNew.value.text = value;
  //   update([
  //     "login"
  //   ]);
  // }

  void togglePasswordVisibility() {
    isObecure.value = !isObecure.value;
    update(["login"]);
  }

  void togglePassword1Visibility() {
    isObsecure1.value = !isObsecure1.value;
    update(["login"]);
  }

  //user Login API
  Future<void> loginApiCall() async {
    if (emailController.value.text.isNotEmpty) {
      Map<String, String> body = {
        "User_Name": emailController.value.text,
        //"Password": passwordController.value.text,
      };
      try {
        isLoading.value = true;
        log("api call");
        log("query Param $body");
        final response = await api.sendRequest.post(
          //  Global.hostUrl + Global.checkLogin,
          '',
          queryParameters: body,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
        log('login number msg : ${response.data}');
        if (response.statusCode == 200 || response.statusCode == 201) {
          isNew.value = response.data["result"];
          if (isNew.value == "Old Login" || isNew.value == "New Login") {
            Get.toNamed("/password_screen");
          } else {
            Get.snackbar("Invalid User", isNew.value,
                colorText: ConstColors.white,
                backgroundColor: ConstColors.primary);
          }
        }
      } on DioException catch (error) {
        if (error.type == DioExceptionType.connectionError) {
          Get.snackbar(
              "Connection lost", "Please check your network and try again",
              colorText: ConstColors.white,
              backgroundColor: ConstColors.primary);
        } else if (error.type == DioExceptionType.connectionTimeout) {
          Get.snackbar("Connection timeout occurred", "Please try again later",
              colorText: ConstColors.white,
              backgroundColor: ConstColors.primary);
        } else if (code == 403) {
          Get.snackbar("User Alert", "User is  Already Logged in",
              colorText: ConstColors.white,
              backgroundColor: ConstColors.primary);
        } else if (error.response!.statusCode! >= 404 &&
            error.response!.statusCode! <= 500) {
          log(" main login status code is ${error.response?.statusCode}");
          Get.snackbar("Error Login", "Invalid login ,please login again",
              colorText: ConstColors.white,
              backgroundColor: ConstColors.primary);
        } else {
          Get.snackbar("Something went wrong", "Please try again",
              colorText: ConstColors.white,
              backgroundColor: ConstColors.primary);
        }
      } catch (error) {
        log('Register number ERROR : $error');
        Get.snackbar("Something went wrong", "$error",
            backgroundColor: ConstColors.white);
      } finally {
        isLoading.value = false;
        update(["login"]);
      }
    } else {
      Get.snackbar("Invalid Input", "Please enter username",
          colorText: ConstColors.white, backgroundColor: ConstColors.primary);
    }
  }
}
