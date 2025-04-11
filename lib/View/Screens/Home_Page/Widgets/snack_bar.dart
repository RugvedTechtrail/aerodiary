import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constDatePicker.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog {
  static void showDiaog(PatientHistoryController controller) {
    final formKey = GlobalKey<FormState>();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              // 🔧 Wrap the entire content in a scroll view
              child: Column(
                mainAxisSize: MainAxisSize.min, // ✅ use min to fit content
                children: [
                  // Header
                  Container(
                    decoration: const BoxDecoration(
                      color: ConstColors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
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
                              'Maintenance Medication',
                              style: getTextTheme().bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Info Box
                  Container(
                    padding:
                        EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
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
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 10.w),
                          child: Text(
                            'Choose your Rescue medication. This field is suitable even if you use the same drug simultaneously in a regular treatment.',
                            style: getTextTheme(
                              color: ConstColors.darkGrey,
                            ).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Medication List
                  ListView.builder(
                    shrinkWrap: true, // Important to avoid infinite height
                    physics:
                        NeverScrollableScrollPhysics(), // Let outer scroll view scroll
                    itemCount: controller.medicationList.length,
                    itemBuilder: (context, index) {
                      final medication = controller.medicationList[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade200, width: 1),
                          ),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              medication.icon,
                              color: Colors.indigo.shade400,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            medication.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.indigo,
                            ),
                          ),
                          subtitle: Text(
                            medication.subtitle,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          onTap: () {
                            // Handle medication tap
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
