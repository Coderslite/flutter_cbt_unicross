import 'package:flutter/material.dart'; // Make sure to import the Flutter material package
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/screens/admin/student_courses.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import '../../utilities/navigation.dart';
import '../../utilities/text.dart';

class AllStudents extends StatefulWidget {
  const AllStudents({Key? key}) : super(key: key);

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  // Sample data of lecturers (you can replace this with your actual data)
  int count = 0;
  CourseController courseController = Get.put(CourseController());
  String name = '';
  String regno = '';
  String department = '';
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
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
            MyText(color: black!, size: 30, text: "All Students"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: blue2),
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AlertDialog(
                          title: MyText(
                              color: black!, size: 17, text: "Add New Student"),
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  courseController.handleAddStudent(
                                      name: name,
                                      regno: regno,
                                      department: department,
                                      email: email,
                                      password: password);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: blue2),
                              child: const MyText(
                                  color: white, size: 18, text: "Proceed"),
                            ),
                          ],
                          content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  onChanged: (value) {
                                    name = value.toString();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: MyText(
                                          color: black!,
                                          size: 14,
                                          text: "Student Name"),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 2),
                                      border: const OutlineInputBorder()),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    regno = value.toString();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: MyText(
                                          color: black!,
                                          size: 14,
                                          text: "Student Regno"),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 2),
                                      border: const OutlineInputBorder()),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    department = value.toString();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: MyText(
                                          color: black!,
                                          size: 14,
                                          text: "Student Department"),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 2),
                                      border: const OutlineInputBorder()),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    email = value.toString();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: MyText(
                                          color: black!,
                                          size: 14,
                                          text: "Email"),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 2),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(color: blue))),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    password = value.toString();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: MyText(
                                          color: black!,
                                          size: 14,
                                          text: "Password"),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 2),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(color: blue))),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child:
                    const MyText(color: white, size: 16, text: "Add Students")),
            DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'ID'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Name'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Regno'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Department'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Email'),
                ),
                // DataColumn(
                //   label: MyText(color: black!, size: 16, text: 'Edit'),
                // ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Delete'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Actions'),
                ),
              ],
              rows: courseController.allStudents.map((student) {
                count++;

                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text('$count')),
                    DataCell(Text(student.name ?? '')),
                    DataCell(Text(student.regno ?? '')),
                    DataCell(Text(student.department ?? '')),
                    DataCell(Text(student.email ?? '')),
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
                                      onPressed: () {
                                        courseController.handleDeleteStudent(
                                            id: student.id);
                                      },
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
                              StudentCourses(
                                userId: student.id,
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
