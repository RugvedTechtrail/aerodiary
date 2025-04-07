import 'package:aerodiary/View/Screens/Patient_Screen/Controller/patient_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constDatePicker.dart';
import 'package:aerodiary/widgets/constTextField.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:aerodiary/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ConstColors.primary,
      appBar: AppBar(
        surfaceTintColor: ConstColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'AeroDiary',
          style: getTextTheme(fontWeight: FontWeight.w400, fontSize: 24)
              .headlineLarge,
        ),
        backgroundColor: ConstColors.primary,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_left,
                    color: ConstColors.buttonColor,
                    size: 45.sp,
                  ),
                  Text(
                    'Add Patient Data',
                    style: getTextTheme().bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Form fields
              GetBuilder(
                  id: 'login',
                  init: PatientController(),
                  builder: (controller) {
                    return Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ConstTextField(
                                customText: 'First Name',
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
                                    controller.firstNameController.value,
                                validator: controller.validateFirstName,
                                keyoardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      '[a-zA-Z0-9@#£_&-+.()\$/*":;!?€¥¢^=-]')),
                                ],
                                onChanged: (value) {
                                  controller.firstNameController.value.text =
                                      value;
                                  controller.update(["login"]);
                                },
                                onSaved: (p0) {
                                  controller.updateFName(p0 ?? '');
                                }),

                            //

                            ConstTextField(
                              customText: 'Last Name',
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
                                  controller.lastNameControllerNew.value,
                              validator: controller.validateLastName,
                              keyoardType: TextInputType.emailAddress,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    '[a-zA-Z0-9@#£_&-+.()\$/*":;!?€¥¢^=-]')),
                              ],
                              onChanged: (value) {
                                // controller.lastNameControllerNew.value.text =
                                //     value;
                                controller.update(["login"]);
                              },
                              onSaved: (p0) {
                                controller.updateLName(p0 ?? '');
                              },
                            ),

                            ConstYearPicker(
                              hintText: 'Date of Birth',
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
                              controller: controller.dateOfBirthController
                                  .value, // ✅ This is now a TextEditingController
                              validator: controller.validateDateOfBirth,
                              onChanged: (value) {
                                // controller.dateOfBirthController.value.text =
                                //     value;
                                controller.update(["login"]);
                              },
                              onSaved: (p0) {
                                controller.updateDob(p0 ?? '');
                              },
                              mandatoryTitle: "Date of Birth",
                            ),

                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              child: DropdownButtonFormField<String>(
                                value: controller.gender.value.isEmpty
                                    ? null
                                    : controller.gender.value,
                                validator: controller.validateGender,
                                icon: const SizedBox(),
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: ConstColors.darkGrey,
                                    size: 45.sp,
                                  ),
                                  fillColor: ConstColors.white,
                                  filled: true,
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: ConstColors.white,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: ConstColors.red,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: ConstColors.white,
                                    ),
                                  ),
                                  errorStyle: GoogleFonts.content(
                                    height: 0.sp,
                                    color: ConstColors.red,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: 'Gender',
                                  hintStyle: GoogleFonts.content(
                                    fontWeight: FontWeight.w400,
                                    color: ConstColors.grey,
                                    fontSize: 16.sp,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: ConstColors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: ConstColors.white,
                                    ),
                                  ),
                                ),
                                items: controller.genderOptions
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.content(
                                        fontWeight: FontWeight.w400,
                                        color: ConstColors.darkGrey,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    //  controller.gender.value = value;
                                    controller.update(["login"]);
                                  }
                                },
                                onSaved: (newValue) {
                                  controller.updateGender(newValue ?? '');
                                },
                              ),
                            ),
                            // Email
                            ConstTextField(
                              customText: 'Email',
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
                              controller: controller.emailController.value,
                              validator: controller.validateEmail,
                              keyoardType: TextInputType.emailAddress,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    '[a-zA-Z0-9@#£_&-+.()\$/*":;!?€¥¢^=-]')),
                              ],
                              onChanged: (value) {
                                //  controller.emailController.value.text = value;
                                controller.update(["login"]);
                              },
                              onSaved: (p0) {
                                controller.updateEmail;
                              },
                            ),

                            // Mobile
                            ConstTextField(
                              customText: 'Mobile',
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
                                  controller.mobileNumberController.value,
                              validator: controller.validateMobile,
                              keyoardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              onChanged: (value) {
                                // controller.mobileNumberController.value.text =
                                //     value;
                                controller.update(["login"]);
                              },
                              onSaved: (p0) {
                                controller.updateMobile(p0 ?? '');
                              },
                            ),

                            // OTP
                            ConstTextField(
                              customText: 'Otp',
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
                              controller: controller.otpControllerNew.value,
                              validator: controller.validateOTP,
                              keyoardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) {
                                // controller.otpControllerNew.value.text = value;
                                controller.update(["login"]);
                              },
                              onSaved: (p0) {
                                controller.updateOtp(p0 ?? '');
                              },
                            ),
                            ConstantButton(
                              press: () {
                                if (formKey.currentState!.validate()) {
                                } else {
                                  Get.snackbar(
                                    "User Alert",
                                    "Please enter all the fields",
                                    backgroundColor:
                                        ConstColors.white.withOpacity(0.8),
                                  );
                                }
                              },
                              text: 'Done',
                              color: ConstColors.buttonColor,
                              bordercolor: ConstColors.buttonColor,
                              borderRadius: 10.sp,
                              height: 45.h,
                              style: getTextTheme().bodyMedium,
                              vertiPadding: 60.h,
                            ),
                            // Done Button
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
