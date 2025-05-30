// import 'package:aerodiary/View/Screens/Patient_Screen/Controller/patient_controller.dart';
// import 'package:aerodiary/constants/const_colors.dart';
// import 'package:aerodiary/constants/custom_textstyle.dart';
// import 'package:aerodiary/widgets/constDatePicker.dart';
// import 'package:aerodiary/widgets/constTextField.dart';
// import 'package:aerodiary/widgets/const_button.dart';
// import 'package:aerodiary/widgets/custom_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class PatientScreen extends StatelessWidget {
//   const PatientScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     return Scaffold(
//       backgroundColor: ConstColors.primary,
//       appBar: AppBar(
//         surfaceTintColor: ConstColors.primary,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           'AeroDiary',
//           style: getTextTheme(fontWeight: FontWeight.w400, fontSize: 24)
//               .headlineLarge,
//         ),
//         backgroundColor: ConstColors.primary,
//         elevation: 0,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.arrow_left,
//                     color: ConstColors.buttonColor,
//                     size: 45.sp,
//                   ),
//                   Text(
//                     'Add Patient Data',
//                     style: getTextTheme().bodyLarge,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Form fields
//               GetBuilder(
//                   id: 'login',
//                   init: PatientController(),
//                   builder: (controller) {
//                     return Form(
//                       key: formKey,
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             ConstTextField(
//                                 customText: 'First Name',
//                                 hintStyle: GoogleFonts.content(
//                                   fontWeight: FontWeight.w400,
//                                   color: ConstColors.grey,
//                                   fontSize: 16.sp,
//                                 ),
//                                 textStyle: GoogleFonts.content(
//                                   fontWeight: FontWeight.w400,
//                                   color: ConstColors.darkGrey,
//                                   fontSize: 16.sp,
//                                 ),
//                                 controller:
//                                     controller.firstNameController.value,
//                                 validator: controller.validateFirstName,
//                                 keyoardType: TextInputType.emailAddress,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.allow(RegExp(
//                                       '[a-zA-Z0-9@#£_&-+.()\$/*":;!?€¥¢^=-]')),
//                                 ],
//                                 onChanged: (value) {
//                                   controller.firstNameController.value.text =
//                                       value;
//                                   controller.update(["login"]);
//                                 },
//                                 onSaved: (p0) {
//                                   controller.updateFName(p0 ?? '');
//                                 }),

//                             //

//                             ConstTextField(
//                               customText: 'Last Name',
//                               hintStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.grey,
//                                 fontSize: 16.sp,
//                               ),
//                               textStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.darkGrey,
//                                 fontSize: 16.sp,
//                               ),
//                               controller:
//                                   controller.lastNameControllerNew.value,
//                               validator: controller.validateLastName,
//                               keyoardType: TextInputType.emailAddress,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.allow(RegExp(
//                                     '[a-zA-Z0-9@#£_&-+.()\$/*":;!?€¥¢^=-]')),
//                               ],
//                               onChanged: (value) {
//                                 // controller.lastNameControllerNew.value.text =
//                                 //     value;
//                                 controller.update(["login"]);
//                               },
//                               onSaved: (p0) {
//                                 controller.updateLName(p0 ?? '');
//                               },
//                             ),

//                             ConstYearPicker(
//                               hintText: 'Date of Birth',
//                               hintStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.grey,
//                                 fontSize: 16.sp,
//                               ),
//                               textStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.darkGrey,
//                                 fontSize: 16.sp,
//                               ),
//                               controller: controller.dateOfBirthController
//                                   .value, // ✅ This is now a TextEditingController
//                               validator: controller.validateDateOfBirth,
//                               iconColor: ConstColors.darkGrey.withOpacity(0.6),
//                               onChanged: (value) {
//                                 // controller.dateOfBirthController.value.text =
//                                 //     value;
//                                 controller.update(["login"]);
//                               },
//                               onSaved: (p0) {
//                                 controller.updateDob(p0 ?? '');
//                               },
//                               mandatoryTitle: "Date of Birth",
//                             ),

//                             Container(
//                               margin: EdgeInsets.symmetric(vertical: 5.h),
//                               child: DropdownButtonFormField<String>(
//                                 value: controller.gender.value.isEmpty
//                                     ? null
//                                     : controller.gender.value,
//                                 validator: controller.validateGender,
//                                 icon: const SizedBox(),
//                                 decoration: InputDecoration(
//                                   suffixIcon: Icon(
//                                     Icons.arrow_drop_down_sharp,
//                                     color:
//                                         ConstColors.darkGrey.withOpacity(0.6),
//                                     size: 45.sp,
//                                   ),
//                                   fillColor: ConstColors.white,
//                                   filled: true,
//                                   disabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       color: ConstColors.white,
//                                     ),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       color: ConstColors.red,
//                                     ),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       color: ConstColors.white,
//                                     ),
//                                   ),
//                                   errorStyle: GoogleFonts.content(
//                                     height: 0.sp,
//                                     color: ConstColors.red,
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                   hintText: 'Gender',
//                                   hintStyle: GoogleFonts.content(
//                                     fontWeight: FontWeight.w400,
//                                     color: ConstColors.grey,
//                                     fontSize: 16.sp,
//                                   ),
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 5.h, horizontal: 10.w),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       color: ConstColors.white,
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       color: ConstColors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 items: controller.genderOptions
//                                     .map<DropdownMenuItem<String>>((value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(
//                                       value,
//                                       style: GoogleFonts.content(
//                                         fontWeight: FontWeight.w400,
//                                         color: ConstColors.darkGrey,
//                                         fontSize: 16.sp,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   if (value != null) {
//                                     //  controller.gender.value = value;
//                                     controller.update(["login"]);
//                                   }
//                                 },
//                                 onSaved: (newValue) {
//                                   controller.updateGender(newValue ?? '');
//                                 },
//                               ),
//                             ),
//                             // Email
//                             ConstTextField(
//                               customText: 'Email',
//                               hintStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.grey,
//                                 fontSize: 16.sp,
//                               ),
//                               textStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.darkGrey,
//                                 fontSize: 16.sp,
//                               ),
//                               controller: controller.emailController.value,
//                               validator: controller.validateEmail,
//                               keyoardType: TextInputType.emailAddress,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.allow(RegExp(
//                                     '[a-zA-Z0-9@#£_&-+.()\$/*":;!?€¥¢^=-]')),
//                               ],
//                               onChanged: (value) {
//                                 //  controller.emailController.value.text = value;
//                                 controller.update(["login"]);
//                               },
//                               onSaved: (p0) {
//                                 controller.updateEmail;
//                               },
//                             ),

//                             // Mobile
//                             ConstTextField(
//                               customText: 'Mobile',
//                               hintStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.grey,
//                                 fontSize: 16.sp,
//                               ),
//                               textStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.darkGrey,
//                                 fontSize: 16.sp,
//                               ),
//                               controller:
//                                   controller.mobileNumberController.value,
//                               validator: controller.validateMobile,
//                               keyoardType: TextInputType.number,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                                 LengthLimitingTextInputFormatter(10),
//                               ],
//                               onChanged: (value) {
//                                 // controller.mobileNumberController.value.text =
//                                 //     value;
//                                 controller.update(["login"]);
//                               },
//                               onSaved: (p0) {
//                                 controller.updateMobile(p0 ?? '');
//                               },
//                             ),

//                             // OTP
//                             ConstTextField(
//                               customText: 'Otp',
//                               hintStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.grey,
//                                 fontSize: 16.sp,
//                               ),
//                               textStyle: GoogleFonts.content(
//                                 fontWeight: FontWeight.w400,
//                                 color: ConstColors.darkGrey,
//                                 fontSize: 16.sp,
//                               ),
//                               controller: controller.otpControllerNew.value,
//                               validator: controller.validateOTP,
//                               keyoardType: TextInputType.number,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                               ],
//                               onChanged: (value) {
//                                 // controller.otpControllerNew.value.text = value;
//                                 controller.update(["login"]);
//                               },
//                               onSaved: (p0) {
//                                 controller.updateOtp(p0 ?? '');
//                               },
//                             ),
//                             ConstantButton(
//                               press: () {
//                                 if (formKey.currentState!.validate()) {
//                                 } else {
//                                   Get.snackbar(
//                                     "User Alert",
//                                     "Please enter all the fields",
//                                     backgroundColor:
//                                         ConstColors.white.withOpacity(0.8),
//                                   );
//                                 }
//                               },
//                               text: 'Done',
//                               color: ConstColors.buttonColor,
//                               bordercolor: ConstColors.buttonColor,
//                               borderRadius: 10.sp,
//                               height: 45.h,
//                               style: getTextTheme().bodyMedium,
//                               vertiPadding: 60.h,
//                             ),
//                             // Done Button
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:aerodiary/View/Screens/Patient_Screen/Controller/patient_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constDatePicker.dart';
import 'package:aerodiary/widgets/constTextField.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Move the formKey to the controller so it's accessible for validation
    return SafeArea(
      child: Scaffold(
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
          margin: EdgeInsets.symmetric(horizontal: 10.w),
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
                        key: controller
                            .formKey, // Use the form key from the controller

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
                                  controller.markFieldAsTouched('firstName');
                                },
                                onSaved: (p0) {
                                  controller.updateFName(p0 ?? '');
                                },
                                // Change this to disabled
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),

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
                                  controller.lastNameControllerNew.value.text =
                                      value;
                                  controller.markFieldAsTouched('lastName');
                                },
                                onSaved: (p0) {
                                  controller.updateLName(p0 ?? '');
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                controller:
                                    controller.dateOfBirthController.value,
                                validator: controller.validateDateOfBirth,
                                iconColor:
                                    ConstColors.darkGrey.withOpacity(0.6),
                                onChanged: (value) {
                                  controller.dateOfBirthController.value.text =
                                      value;
                                  controller.markFieldAsTouched('dob');
                                },
                                onSaved: (p0) {
                                  controller.updateDob(p0 ?? '');
                                },
                                // Change this to disabled
                                autovalidateMode: AutovalidateMode.disabled,
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
                                  hint: Text(
                                    'Gender',
                                    style: GoogleFonts.content(
                                      fontWeight: FontWeight.w400,
                                      color: ConstColors
                                          .grey, // This should force the color
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color:
                                          ConstColors.darkGrey.withOpacity(0.6),
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
                                      color: ConstColors
                                          .blue, // Changed back to blue as requested
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
                                      controller.gender.value = value;
                                      controller.markFieldAsTouched('gender');
                                      // controller.formKey.currentState
                                      //     ?.validate(); // Validate on change
                                      controller.update(["login"]);
                                    }
                                  },
                                  onSaved: (newValue) {
                                    controller.updateGender(newValue ?? '');
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.content(
                                    // Add this explicit style
                                    fontWeight: FontWeight.w400,
                                    color: ConstColors.grey,
                                    fontSize: 16.sp,
                                  ),
                                  dropdownColor: ConstColors.white,
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
                                  controller.emailController.value.text = value;
                                  // controller.formKey.currentState
                                  //     ?.validate(); // Validate on change
                                  controller.markFieldAsTouched('email');
                                  controller.update(["login"]);
                                },
                                onSaved: (p0) {
                                  controller.updateEmail(p0 ?? '');
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                  controller.mobileNumberController.value.text =
                                      value;
                                  controller.markFieldAsTouched('mobile');
                                  // controller.formKey.currentState
                                  //     ?.validate(); // Validate on change
                                  controller.update(["login"]);
                                },
                                onSaved: (p0) {
                                  controller.updateMobile(p0 ?? '');
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                  controller.otpControllerNew.value.text =
                                      value;
                                  controller.markFieldAsTouched('otp');
                                  // controller.formKey.currentState
                                  //     ?.validate(); // Validate on change
                                  controller.update(["login"]);
                                },
                                onSaved: (p0) {
                                  controller.updateOtp(p0 ?? '');
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),

                              AnimatedContainer(
                                margin: EdgeInsets.symmetric(vertical: 55.h),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                width:
                                    controller.isLoading.value ? 60.w : 360.w,
                                height: 42
                                    .h, // Match this with the ConstantButton height
                                decoration: BoxDecoration(
                                  color: controller.isLoading.value
                                      ? ConstColors.primary
                                      : ConstColors.buttonColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: controller.isLoading.value
                                    ? Center(
                                        child: SizedBox(
                                          height: 32.h,
                                          width: 32.w,
                                          child: LoadingIndicator(
                                            indicatorType:
                                                Indicator.ballRotateChase,
                                            colors: const [ConstColors.white],
                                            strokeWidth: 5.sp,
                                          ),
                                        ),
                                      )
                                    : ConstantButton(
                                        press: () {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            controller.formKey.currentState!
                                                .save();
                                            // Continue with your form submission logic
                                            controller.login();

                                            //Get.toNamed('/dashboard_screen');
                                          } else {
                                            Get.snackbar(
                                              "User Alert !",
                                              "Please enter all the fields",
                                              backgroundColor: ConstColors.snack
                                                  .withOpacity(0.8),
                                              colorText: ConstColors.white,
                                              snackStyle: SnackStyle.FLOATING,
                                              margin: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 8.w,
                                              ),
                                            );
                                          }
                                        },
                                        text: 'Done',
                                        color: ConstColors.buttonColor,
                                        bordercolor: ConstColors
                                            .buttonColor, // Make transparent to avoid double borders
                                        borderRadius: 10.sp,
                                        height: 45.h,
                                        style: getTextTheme().bodyMedium,
                                      ),
                              )

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
      ),
    );
  }
}
