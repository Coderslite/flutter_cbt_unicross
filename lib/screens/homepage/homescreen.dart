// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:unicross_cbt_desktop_app/controllers/sidebar_navigation_controller.dart';
// import 'package:unicross_cbt_desktop_app/screens/dashboard/dashboard.dart';
// import 'package:unicross_cbt_desktop_app/screens/exams/lecturer_exam/upload_exam_questions.dart';
// import 'package:unicross_cbt_desktop_app/screens/exams/lecturer_exam/exam_questions.dart';
// import 'package:unicross_cbt_desktop_app/screens/sidebar/student_side_bar.dart';

// import '../exams/exam_screen.dart';
// import '../sidebar/lecturer_side_bar.dart';

// class Homepage extends StatefulWidget {
//   final String type;
//   const Homepage({super.key, required this.type});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   SideNavigationController sideNavigationController =
//       Get.put(SideNavigationController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => Row(
//           children: [
//             widget.type == 'admin' ? const SideBar() : const StudentSideBar(),
//             widget.type == 'admin'
//                 ? sideBarScreens[sideNavigationController.index.value]
//                 : studentSideBarScreens[sideNavigationController.index.value],
//           ],
//         ),
//       ),
//     );
//   }

//   List sideBarScreens = <Widget>[
//     const DashboardScreen(),
//     const UploadExamQuestions(),
//     const ExamQuestions(),
//     const Center(
//       child: Text("Home4"),
//     ),
//   ];

//   List studentSideBarScreens = <Widget>[
//     const ExamScreen(),
//   ];
// }
