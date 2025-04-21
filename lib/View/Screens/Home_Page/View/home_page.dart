import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/home_header_widget.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/page_view_container_widget.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: ConstColors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button
            HomeHeaderWidget(
              onBackPressed: () {
                // Handle back button press (e.g., navigate back to dashboard)
                Get.back();
              },
            ),

            // Optional: Progress indicator
            // Uncomment if you want to show progress
            /*
              Obx(() => LinearProgressIndicator(
                    value: (controller.currentPageIndex.value + 1) /
                        controller.totalPages,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF4BA8A5)),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: Obx(() => Text(
                      'Step ${controller.currentPageIndex.value + 1} of ${controller.totalPages}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                      ),
                    )),
              ),
              */

            // Main Content with PageView
            PageViewContainerWidget(controller: controller),
          ],
        ),
      ),
    );
  }
}
