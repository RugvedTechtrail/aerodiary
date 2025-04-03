import 'dart:developer';
import 'dart:io';

import 'package:aerodiary/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final Map<String, dynamic>? arguments =
      Get.arguments as Map<String, dynamic>?;
  int? selectedIndex;
  PageController? _pageController;
  final List<Widget> widgetOptions = [];

  @override
  void initState() {
    super.initState();
    log("currentIndex ${Get.parameters['currentIndex']}");
    log("selectedIndex ${arguments?['currentIndex']}");
    selectedIndex = int.parse(arguments?['currentIndex'] ?? "1");
    int currentIndexPage = int.parse(Get.parameters['currentIndex'] ?? '1');
    _pageController = PageController(
      initialPage: int.parse(Get.parameters['currentIndex'] ?? '1'),
    );
    selectedIndex = int.parse(Get.parameters['currentIndex'] ?? '1');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (canPop) {
        canPop = !canPop;
        log("Canpop is $canPop");
        exitDialog();
      },
      child: Scaffold(
        body: PageView(
          onPageChanged: onPageChanged,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ConstColors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: ConstColors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.article, size: 30.sp), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30.sp), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30.sp), label: ""),
          ],
          currentIndex: selectedIndex!,
          fixedColor: ConstColors.primary,
          onTap: onTabTapped,
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onTabTapped(int index) {
    _pageController!.animateToPage(index,
        duration: const Duration(milliseconds: 1), curve: Curves.linear);
  }

/*  exitDialog() {
    return showDialog(
        barrierDismissible: true,
        barrierColor: ConstColors.lightpurple.withOpacity(0.1),
        context: context,
        builder: (context) => customDialogueWithCancel(
          backgroundColor: ConstColors.purple,
          content: "Are you sure you want to exit from app?",
          dismissBtnTitle: "Yes",
          onClick: () {
            exit(0);
          },
          cancelBtn: 'Cancel',
          onCancelClick: () => Navigator.pop(context),
          title: "Hold on!",
        ));
  }*/

  exitDialog() {
    return showDialog(
        barrierDismissible: true,
        barrierColor: ConstColors.primary.withOpacity(0.1),
        context: context,
        builder: (context) {
          return const SizedBox();
        });
  }
}
