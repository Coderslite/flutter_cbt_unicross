import 'package:flutter/material.dart'; // Make sure to import the Flutter material package
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import '../../utilities/navigation.dart';
import '../../utilities/text.dart';

class AllLecturers extends StatefulWidget {
  const AllLecturers({Key? key}) : super(key: key);

  @override
  State<AllLecturers> createState() => _AllLecturersState();
}

class _AllLecturersState extends State<AllLecturers> {
  // Sample data of lecturers (you can replace this with your actual data)
  CourseController courseController = Get.put(CourseController());
  int count = 0;
  String name = '';
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    count = 0;
    super.dispose();
  }

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
            MyText(color: black!, size: 30, text: "All Lecturers"),
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
                              color: black!,
                              size: 17,
                              text: "Add New Lecturer"),
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
                                  courseController.handleAddLecturer(
                                      name: name,
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
                                          text: "Lecturer Name"),
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
                                          borderSide:
                                              BorderSide(color: blue2))),
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
                                          borderSide:
                                              BorderSide(color: blue2))),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child:
                    const MyText(color: white, size: 16, text: "Add Lecturer")),
            DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'ID'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Name'),
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
              ],
              rows: courseController.allLecturers.map((lecturer) {
                count++;
                return DataRow(
                  cells: <DataCell>[
                    DataCell(MyText(color: black!, size: 16, text: '$count')),
                    DataCell(MyText(
                        color: black!, size: 16, text: lecturer.name ?? '')),
                    DataCell(MyText(
                        color: black!, size: 16, text: lecturer.email ?? '')),
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
                                        courseController.handleDeleteLecturer(
                                            id: lecturer.id);
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
