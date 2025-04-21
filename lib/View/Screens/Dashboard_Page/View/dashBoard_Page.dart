import 'dart:developer';
import 'dart:io';

import 'package:aerodiary/View/Screens/Drugs_Page/View/drugs_page.dart';
import 'package:aerodiary/View/Screens/Home_Page/View/home_page.dart';
import 'package:aerodiary/View/Screens/Test_Screen/View/test_screen.dart';
import 'package:aerodiary/View/Screens/Trends_Page/View/trends_screen.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0; // Default to Home page
  late PageController _pageController;
  late List<Widget> widgetOptions;

  @override
  void initState() {
    super.initState();
    // Initialize the page controller with home as default
    _pageController = PageController(initialPage: selectedIndex);

    // Initialize the pages
    widgetOptions = [
      const HomePage(),
      const TestScreen(),
      const TrendsScreen(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Don't allow normal back button behavior
      onPopInvoked: (didPop) {
        if (!didPop) {
          exitDialog();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            onPageChanged: onPageChanged,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: widgetOptions,
          ),
          bottomNavigationBar: Container(
            child: BottomNavigationBar(
              backgroundColor: ConstColors.primary,
              elevation: 10.sp,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: ConstColors.buttonColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 26.sp,
                    color: ConstColors.buttonColor,
                  ),
                  activeIcon: Icon(
                    Icons.home_sharp,
                    size: 26.sp,
                    color: ConstColors.buttonColor,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shield_outlined,
                    size: 26.sp,
                    color: ConstColors.buttonColor,
                  ),
                  activeIcon: Icon(
                    Icons.shield_sharp,
                    size: 26.sp,
                    color: ConstColors.buttonColor,
                  ),
                  label: "Drugs",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.pie_chart_outline,
                    size: 26.sp,
                    color: ConstColors.buttonColor,
                  ),
                  activeIcon: Icon(
                    Icons.pie_chart_sharp,
                    size: 26.sp,
                    color: ConstColors.buttonColor,
                  ),
                  label: "Trends",
                ),
              ],
              currentIndex: selectedIndex ?? 0,
              selectedItemColor: ConstColors.buttonColor,
              onTap: onTabTapped,
              selectedFontSize: 15.sp,
              unselectedFontSize: 12.sp,
            ),
          ),
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
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  exitDialog() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ConstColors.buttonColor,
          title: Text(
            "Exit App",
            style: getTextTheme().bodyLarge,
          ),
          content: Text(
            "Are you sure you want to exit the app?",
            style: getTextTheme().bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: getTextTheme().bodyMedium,
              ),
            ),
            TextButton(
              onPressed: () => exit(0),
              child: Text(
                "Yes",
                style: getTextTheme().bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ConstColors.primary,
//         elevation: 0,
//         title: Text(
//           'Home',
//           style: TextStyle(
//             color: ConstColors.white,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Welcome section
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20.w),
//                 decoration: BoxDecoration(
//                   color: ConstColors.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome to AeroDiary',
//                       style: TextStyle(
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.bold,
//                         color: ConstColors.primary,
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Track your medication and health trends in one place',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24.h),

//               // Quick stats
//               Text(
//                 'Quick Stats',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 12.h),

//               Row(
//                 children: [
//                   _buildStatCard(
//                     title: 'Medications',
//                     value: '5',
//                     icon: Icons.medication_outlined,
//                     color: Colors.blue,
//                   ),
//                   SizedBox(width: 12.w),
//                   _buildStatCard(
//                     title: 'Reminders',
//                     value: '3',
//                     icon: Icons.alarm,
//                     color: Colors.orange,
//                   ),
//                 ],
//               ),

//               SizedBox(height: 24.h),

//               // Recent Activity
//               Text(
//                 'Recent Activity',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 12.h),

//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return _buildActivityItem(
//                       title: 'Medication reminder',
//                       description: 'You took Ventolin at 9:00 AM',
//                       time: '2h ago',
//                       icon: Icons.check_circle_outline,
//                       color: Colors.green,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard({
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: color.withOpacity(0.3), width: 1),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, color: color, size: 22.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActivityItem({
//     required String title,
//     required String description,
//     required String time,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(8.w),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: color, size: 20.sp),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   description,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             time,
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: Colors.black45,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DrugsPage extends StatefulWidget {
//   const DrugsPage({Key? key}) : super(key: key);

//   @override
//   State<DrugsPage> createState() => _DrugsPageState();
// }

// class _DrugsPageState extends State<DrugsPage> {
//   final List<Map<String, dynamic>> medications = [
//     {
//       'name': 'Ventolin',
//       'dosage': '100mcg',
//       'schedule': 'As needed',
//       'type': 'Inhaler',
//       'color': Colors.blue,
//       'icon': Icons.air,
//     },
//     {
//       'name': 'Singulair',
//       'dosage': '10mg',
//       'schedule': 'Once daily',
//       'type': 'Tablet',
//       'color': Colors.orange,
//       'icon': Icons.medication_outlined,
//     },
//     {
//       'name': 'Flovent',
//       'dosage': '110mcg',
//       'schedule': 'Twice daily',
//       'type': 'Inhaler',
//       'color': Colors.purple,
//       'icon': Icons.air,
//     },
//     {
//       'name': 'Prednisone',
//       'dosage': '5mg',
//       'schedule': 'Once daily',
//       'type': 'Tablet',
//       'color': Colors.red,
//       'icon': Icons.medication_outlined,
//     },
//     {
//       'name': 'Xolair',
//       'dosage': '150mg',
//       'schedule': 'Monthly',
//       'type': 'Injection',
//       'color': Colors.green,
//       'icon': Icons.local_hospital_outlined,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ConstColors.primary,
//         elevation: 0,
//         title: Text(
//           'My Medications',
//           style: TextStyle(
//             color: ConstColors.white,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: ConstColors.white, size: 24.sp),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Filter chips
//               SizedBox(
//                 height: 40.h,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     _buildFilterChip(label: 'All', isSelected: true),
//                     SizedBox(width: 8.w),
//                     _buildFilterChip(label: 'Inhalers'),
//                     SizedBox(width: 8.w),
//                     _buildFilterChip(label: 'Tablets'),
//                     SizedBox(width: 8.w),
//                     _buildFilterChip(label: 'Injections'),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 20.h),

//               Text(
//                 'Your Medications',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),

//               SizedBox(height: 12.h),

//               Expanded(
//                 child: ListView.builder(
//                   itemCount: medications.length,
//                   itemBuilder: (context, index) {
//                     final medication = medications[index];
//                     return _buildMedicationCard(
//                       name: medication['name'],
//                       dosage: medication['dosage'],
//                       schedule: medication['schedule'],
//                       type: medication['type'],
//                       color: medication['color'],
//                       icon: medication['icon'],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: ConstColors.primary,
//         child: Icon(Icons.add, size: 24.sp),
//         onPressed: () {},
//       ),
//     );
//   }

//   Widget _buildFilterChip({required String label, bool isSelected = false}) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: isSelected ? ConstColors.primary : Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 14.sp,
//           color: isSelected ? Colors.white : Colors.black87,
//           fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//         ),
//       ),
//     );
//   }

//   Widget _buildMedicationCard({
//     required String name,
//     required String dosage,
//     required String schedule,
//     required String type,
//     required Color color,
//     required IconData icon,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(12.w),
//         leading: Container(
//           padding: EdgeInsets.all(8.w),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.2),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: color, size: 24.sp),
//         ),
//         title: Text(
//           name,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 4.h),
//             Text(
//               'Dosage: $dosage',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.black54,
//               ),
//             ),
//             SizedBox(height: 2.h),
//             Text(
//               'Schedule: $schedule',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.black54,
//               ),
//             ),
//             SizedBox(height: 2.h),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(4.r),
//               ),
//               child: Text(
//                 type,
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: color,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.more_vert, size: 20.sp),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }
// }

// class TrendsPage extends StatefulWidget {
//   const TrendsPage({Key? key}) : super(key: key);

//   @override
//   State<TrendsPage> createState() => _TrendsPageState();
// }

// class _TrendsPageState extends State<TrendsPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<String> _timeFrames = ['Week', 'Month', '3 Months', 'Year'];
//   String _selectedTimeFrame = 'Month';

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ConstColors.primary,
//         elevation: 0,
//         title: Text(
//           'Health Trends',
//           style: TextStyle(
//             color: ConstColors.white,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white.withOpacity(0.7),
//           labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
//           unselectedLabelStyle: TextStyle(fontSize: 14.sp),
//           tabs: const [
//             Tab(text: 'Symptoms'),
//             Tab(text: 'Medication'),
//             Tab(text: 'Triggers'),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 16.h),

//             // Time frame selector
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Time Frame:',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(20.r),
//                     ),
//                     child: DropdownButton<String>(
//                       value: _selectedTimeFrame,
//                       icon: const Icon(Icons.arrow_drop_down),
//                       elevation: 16,
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 14.sp,
//                       ),
//                       underline: Container(height: 0),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedTimeFrame = newValue!;
//                         });
//                       },
//                       items: _timeFrames
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 16.h),

//             // Tab content
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildSymptomsTab(),
//                   _buildMedicationTab(),
//                   _buildTriggersTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSymptomsTab() {
//     return Padding(
//       padding: EdgeInsets.all(16.w),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Chart placeholder
//             Container(
//               width: double.infinity,
//               height: 200.h,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Center(
//                 child: Text(
//                   'Symptoms Chart',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: 24.h),

//             Text(
//               'Most Common Symptoms',
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),

//             SizedBox(height: 12.h),

//             _buildSymptomItem(
//               symptom: 'Shortness of Breath',
//               frequency: '15 episodes',
//               percentage: 75,
//               color: Colors.red,
//             ),

//             _buildSymptomItem(
//               symptom: 'Coughing',
//               frequency: '12 episodes',
//               percentage: 60,
//               color: Colors.orange,
//             ),

//             _buildSymptomItem(
//               symptom: 'Wheezing',
//               frequency: '8 episodes',
//               percentage: 40,
//               color: Colors.yellow.shade800,
//             ),

//             _buildSymptomItem(
//               symptom: 'Chest Tightness',
//               frequency: '5 episodes',
//               percentage: 25,
//               color: Colors.green,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMedicationTab() {
//     return Padding(
//       padding: EdgeInsets.all(16.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Chart placeholder
//           Container(
//             width: double.infinity,
//             height: 200.h,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Center(
//               child: Text(
//                 'Medication Usage Chart',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(height: 24.h),

//           Text(
//             'Medication Usage',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           SizedBox(height: 12.h),

//           _buildMedicationUsageItem(
//             medication: 'Ventolin',
//             usage: '35 times',
//             color: Colors.blue,
//           ),

//           _buildMedicationUsageItem(
//             medication: 'Flovent',
//             usage: '60 times',
//             color: Colors.purple,
//           ),

//           _buildMedicationUsageItem(
//             medication: 'Singulair',
//             usage: '30 times',
//             color: Colors.orange,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTriggersTab() {
//     return Padding(
//       padding: EdgeInsets.all(16.w),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Chart placeholder
//             Container(
//               width: double.infinity,
//               height: 200.h,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Center(
//                 child: Text(
//                   'Triggers Impact Chart',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: 24.h),

//             Text(
//               'Common Triggers',
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),

//             SizedBox(height: 12.h),

//             _buildTriggerItem(
//               trigger: 'Exercise',
//               impact: 'High',
//               percentage: 80,
//               color: Colors.red,
//             ),

//             _buildTriggerItem(
//               trigger: 'Dust',
//               impact: 'Medium',
//               percentage: 55,
//               color: Colors.orange,
//             ),

//             _buildTriggerItem(
//               trigger: 'Cold Air',
//               impact: 'Medium',
//               percentage: 45,
//               color: Colors.amber,
//             ),

//             _buildTriggerItem(
//               trigger: 'Pet Dander',
//               impact: 'Low',
//               percentage: 30,
//               color: Colors.green,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSymptomItem({
//     required String symptom,
//     required String frequency,
//     required int percentage,
//     required Color color,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 symptom,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 frequency,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4.r),
//             child: LinearProgressIndicator(
//               value: percentage / 100,
//               minHeight: 8.h,
//               color: color,
//               backgroundColor: Colors.grey.shade300,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMedicationUsageItem({
//     required String medication,
//     required String usage,
//     required Color color,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 medication,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 usage,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4.r),
//             child: LinearProgressIndicator(
//               value: 1.0, // Assuming full bar for now
//               minHeight: 8.h,
//               color: color,
//               backgroundColor: Colors.grey.shade300,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTriggerItem({
//     required String trigger,
//     required String impact,
//     required int percentage,
//     required Color color,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 trigger,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 impact,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4.r),
//             child: LinearProgressIndicator(
//               value: percentage / 100,
//               minHeight: 8.h,
//               color: color,
//               backgroundColor: Colors.grey.shade300,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
