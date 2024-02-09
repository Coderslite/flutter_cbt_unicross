import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/course_controller.dart';
import '../../utilities/color.dart';
import '../../utilities/text.dart';

class LecturerCourses extends StatefulWidget {
  final String currentLecturer;
  final String courseId;
  const LecturerCourses(
      {super.key, required this.currentLecturer, required this.courseId});

  @override
  State<LecturerCourses> createState() => _LecturerCoursesState();
}

class _LecturerCoursesState extends State<LecturerCourses> {
  CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.07,
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: const [
                BackButton(),
                SizedBox(
                  width: 10,
                ),
                MyText(
                    color: blue2,
                    size: 30,
                    text: "Choose Lecturer to Assign English to"),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: courseController.allLecturers.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var lecturer = courseController.allLecturers[index];
                    return ListTile(
                      leading: MyText(color: black!, size: 16, text: "1"),
                      title: MyText(
                          color: black!,
                          size: 18,
                          text: lecturer.name.toString()),
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  widget.currentLecturer == lecturer.id
                                      ? darkBlue
                                      : green),
                          onPressed: () {
                            courseController.handleAssignCourseToLecture(
                                widget.courseId, lecturer.id, context);
                          },
                          child: MyText(
                              color: white,
                              size: 14,
                              text: widget.currentLecturer == lecturer.id
                                  ? "Course Already Assigned "
                                  : "Assign Now")),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
