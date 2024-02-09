import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/course_controller.dart';
import '../../utilities/color.dart';
import '../../utilities/text.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class StudentCourses extends StatefulWidget {
  final String userId;
  const StudentCourses({super.key, required this.userId});

  @override
  State<StudentCourses> createState() => _StudentCoursesState();
}

class _StudentCoursesState extends State<StudentCourses> {
  CourseController courseController = Get.put(CourseController());

  @override
  void initState() {
    courseController.handleGetStudentCoursesById(widget.userId);
    super.initState();
  }

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
        child: Obx(
          () => Column(
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
                      text:
                          "Click on the courses you want to register for this student"),
                ],
              ),
              MultiSelectDialogField(
                searchHint: "Select the courses to assign to student",
                backgroundColor: white,
                items: courseController.allcourses
                    .map((e) => MultiSelectItem(e, e.courseTitle))
                    .toList(),
                listType: MultiSelectListType.LIST,
                onConfirm: (values) {
                  courseController.handleAssignCourseToStudent(
                      values, widget.userId, context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  MyText(color: black!, size: 26, text: "Student Course List"),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: courseController.studentCourses.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var course = courseController.studentCourses[index];
                      return ListTile(
                        leading: MyText(
                            color: black!, size: 16, text: "${index + 1}"),
                        title: MyText(
                            color: black!,
                            size: 18,
                            text: course.courseTitle.toString()),
                        trailing: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(backgroundColor: red),
                            onPressed: () {
                              courseController.handleRemoveStudentFromCourse(
                                  course.id, widget.userId, context);
                            },
                            child: const MyText(
                                color: white, size: 14, text: "Remove")),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
