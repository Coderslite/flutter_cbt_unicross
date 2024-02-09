import 'package:flutter/material.dart'; // Make sure to import the Flutter material package
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import '../../utilities/navigation.dart';
import '../../utilities/text.dart';
import 'lecturer_courses.dart';

class AllCourses extends StatefulWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  // Sample data of lecturers (you can replace this with your actual data)
  CourseController courseController = Get.put(CourseController());
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.07,
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(color: black!, size: 30, text: "All Courses"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: blue2),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: MyText(
                              color: black!, size: 17, text: "Add New Course"),
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigate.back(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: red),
                              child: const MyText(
                                  color: white, size: 18, text: "Close"),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: blue2),
                              child: const MyText(
                                  color: white, size: 18, text: "Proceed"),
                            ),
                          ],
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    label: MyText(
                                        color: black!,
                                        size: 14,
                                        text: "Lecturer Name"),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 2),
                                    border: const OutlineInputBorder()),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    label: MyText(
                                        color: black!, size: 14, text: "Email"),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 2),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: blue2))),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    label: MyText(
                                        color: black!,
                                        size: 14,
                                        text: "Password"),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 2),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: blue2))),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child:
                    const MyText(color: white, size: 16, text: "Add Course")),
            DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'ID'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Course Title'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Course Code'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Lecturer'),
                ),
                // DataColumn(
                //   label: MyText(color: black!, size: 16, text: 'Edit'),
                // ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Delete'),
                ),
                DataColumn(
                  label: MyText(
                    text: 'Assign',
                    color: black!,
                    size: 16,
                  ),
                ),
              ],
              rows: courseController.allcourses.map((course) {
                count++;
                return DataRow(
                  cells: <DataCell>[
                    DataCell(MyText(
                      text: '$count',
                      size: 16,
                      color: black!,
                    )),
                    DataCell(MyText(
                        size: 16,
                        color: black!,
                        text: course.courseTitle ?? '')),
                    DataCell(MyText(
                        color: black!,
                        size: 16,
                        text: course.courseCode ?? '')),
                    DataCell(MyText(
                        color: black!,
                        size: 16,
                        text: course.lecturer == null
                            ? 'Not Assigned'
                            : course.lecturer['name'])),
                    // DataCell(
                    //   ElevatedButton(
                    //     onPressed: () {
                    //       showDialog(
                    //           context: context,
                    //           builder: (_) {
                    //             return AlertDialog(
                    //               title: MyText(
                    //                   color: black!,
                    //                   size: 17,
                    //                   text: "Edit Lecturer"),
                    //               actionsAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               actions: [
                    //                 ElevatedButton(
                    //                   onPressed: () {
                    //                     Navigate.back(context);
                    //                   },
                    //                   style: ElevatedButton.styleFrom(
                    //                       backgroundColor: red),
                    //                   child: const MyText(
                    //                       color: white,
                    //                       size: 18,
                    //                       text: "Close"),
                    //                 ),
                    //                 ElevatedButton(
                    //                   onPressed: () {},
                    //                   style: ElevatedButton.styleFrom(
                    //                       backgroundColor: blue2),
                    //                   child: const MyText(
                    //                       color: white,
                    //                       size: 18,
                    //                       text: "Proceed"),
                    //                 ),
                    //               ],
                    //               content: Column(
                    //                 mainAxisSize: MainAxisSize.min,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   TextFormField(
                    //                     decoration: InputDecoration(
                    //                         label: MyText(
                    //                             color: black!,
                    //                             size: 14,
                    //                             text: "Lecturer Name"),
                    //                         contentPadding:
                    //                             const EdgeInsets.symmetric(
                    //                                 vertical: 10,
                    //                                 horizontal: 2),
                    //                         border: const OutlineInputBorder()),
                    //                   ),
                    //                   const SizedBox(
                    //                     height: 5,
                    //                   ),
                    //                   TextFormField(
                    //                     decoration: InputDecoration(
                    //                         label: MyText(
                    //                             color: black!,
                    //                             size: 14,
                    //                             text: "Email"),
                    //                         contentPadding:
                    //                             const EdgeInsets.symmetric(
                    //                                 vertical: 10,
                    //                                 horizontal: 2),
                    //                         border: const OutlineInputBorder(
                    //                             borderSide:
                    //                                 BorderSide(color: blue2))),
                    //                   ),
                    //                   const SizedBox(
                    //                     height: 5,
                    //                   ),
                    //                   TextFormField(
                    //                     decoration: InputDecoration(
                    //                         label: MyText(
                    //                             color: black!,
                    //                             size: 14,
                    //                             text: "Password"),
                    //                         contentPadding:
                    //                             const EdgeInsets.symmetric(
                    //                                 vertical: 10,
                    //                                 horizontal: 2),
                    //                         border: const OutlineInputBorder(
                    //                             borderSide:
                    //                                 BorderSide(color: blue2))),
                    //                   ),
                    //                 ],
                    //               ),
                    //             );
                    //           });
                    //     },
                    //     style: ElevatedButton.styleFrom(backgroundColor: blue2),
                    //     child: const Icon(Icons.edit),
                    //   ),
                    // ),
                   
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: MyText(
                                      color: black!,
                                      size: 17,
                                      text: "Do you want to delete this user?"),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigate.back(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: red),
                                      child: const MyText(
                                          color: white,
                                          size: 18,
                                          text: "Close"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: blue2),
                                      child: const MyText(
                                          color: white,
                                          size: 18,
                                          text: "Proceed"),
                                    ),
                                  ],
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: red),
                        child: const Icon(Icons.delete),
                      ),
                    ),
                    DataCell(ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: green),
                        onPressed: () {
                          Navigate.forward(
                              context,
                              LecturerCourses(
                                currentLecturer: course.lecturer == null ||
                                        course.lecturer == {}
                                    ? ''
                                    : course.lecturer['_id'].toString(),
                                courseId: course.id,
                              ));
                        },
                        child: const Text("Assign"))),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
