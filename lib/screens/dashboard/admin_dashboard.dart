import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/controllers/profile_controller.dart';

import '../../utilities/color.dart';
import '../../utilities/text.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  CourseController courseController = Get.put(CourseController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    courseController.handleGetAllLecturers();
    courseController.handleGetAllCourses();
    courseController.handleGetAllStudents();
    super.initState();
  }

  String formattedValue() {
    final examDurationInSeconds =
        courseController.courseModel.value!.examDuration!;
    final hours = Duration(seconds: examDurationInSeconds).inHours;
    final minutes = Duration(seconds: examDurationInSeconds).inMinutes;

    final formattedDuration = '$hours hr ${minutes % 60} min(s)';
    return formattedDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.07,
          image: AssetImage("assets/images/logo.png"),
        ),
      ),
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Obx(() {
        String value = '';
        if (courseController.courseModel.value != null) {
          value = formattedValue();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(color: black!, size: 37, text: "Admin Dashboard"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4.3,
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: blue2,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              size: 30,
                              color: white,
                              text: courseController.allLecturers.length
                                  .toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 3,
                          ),
                          const MyText(
                            size: 14,
                            color: white,
                            text: "All Lecturers",
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4.3,
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              size: 30,
                              color: white,
                              text: courseController.allcourses.length
                                  .toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 3,
                          ),
                          const MyText(
                            size: 14,
                            color: white,
                            text: "All Courses",
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4.3,
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              size: 30,
                              color: white,
                              text: courseController.allStudents.length
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 3,
                          ),
                          MyText(
                            size: 14,
                            color: white,
                            text: "All Students",
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Text("DEVELOPED BY OSSAI ABRAHAM")
          ],
        );
      }),
    );
  }
}
