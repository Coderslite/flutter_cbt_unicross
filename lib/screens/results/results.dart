import 'package:flutter/material.dart'; // Make sure to import the Flutter material package
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import '../../utilities/navigation.dart';
import '../../utilities/text.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // Sample data of lecturers (you can replace this with your actual data)
  CourseController courseController = Get.put(CourseController());
  int count = 0;

  @override
  void initState() {
    courseController.handleGetResults(courseController.lCourseId.value);
    super.initState();
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
            MyText(color: black!, size: 30, text: "Submitted Results"),
            const SizedBox(
              height: 20,
            ),
            DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'ID'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Student Name'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Student Regno'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Department'),
                ),
                DataColumn(
                  label: MyText(color: black!, size: 16, text: 'Score'),
                ),
              ],
              rows: courseController.results.map((result) {
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
                        text: result.student['name'] ?? '')),
                    DataCell(MyText(
                        color: black!,
                        size: 16,
                        text: result.student['regno'] ?? '')),
                    DataCell(MyText(
                        color: black!,
                        size: 16,
                        text: result.student['department'])),
                    DataCell(MyText(
                        color: black!,
                        size: 16,
                        text: result.score.toString())),
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
