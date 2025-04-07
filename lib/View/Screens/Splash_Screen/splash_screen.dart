import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // GetStorage().read("authToken") != null
      //     ? Get.offAllNamed('/dashboard_screen')
      //     : Get.offAllNamed("/login_screen");
      // //  Get.offAllNamed("/login_screen");
      Get.offAllNamed('/starting_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.primary,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstWidget.contText(
              'AeroDiary',
              style: getTextTheme(
                fontSize: 26.sp,
                fontWeight: FontWeight.w500,
              ).headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
