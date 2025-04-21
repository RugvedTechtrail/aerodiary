import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [],
      ),
    );
  }
}
