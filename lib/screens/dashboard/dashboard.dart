import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/controllers/profile_controller.dart';
import 'package:unicross_cbt_desktop_app/utilities/navigation.dart';

import '../../utilities/color.dart';
import '../../utilities/text.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CourseController courseController = Get.put(CourseController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    courseController.handleGetCourseQuestions(true);
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

        return courseController.courseModel.value == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profileController.profileType.value == 'lecturer'
                      ? Text("${courseController.sCourseTitle}")
                      : Text("Course: ${courseController.sCourseTitle}"),
                  const Text("No Course Selected Yet"),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      MyText(
                          color: black!,
                          size: 30,
                          text: courseController.courseModel.value!.courseTitle
                              .toString()),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4.3,
                            height: 160,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: teal,
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
                              children: [
                                const CircleAvatar(
                                    backgroundColor: yellow,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(FluentIcons.questionnaire),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyText(
                                  size: 22,
                                  color: white,
                                  text: courseController.questions.length
                                      .toString(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const MyText(
                                  size: 14,
                                  color: white,
                                  text: "Exam Questions",
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 4.3,
                            height: 160,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: darkBlue,
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
                              children: [
                                MyText(
                                    color: white,
                                    size: 26,
                                    text: courseController.courseModel.value!
                                                .examDuration ==
                                            null
                                        ? "Not available"
                                        : value),
                                const MyText(
                                    color: white,
                                    size: 14,
                                    text: "Exam Duration"),
                                const SizedBox(height: 10),
                                Button(
                                  style: ButtonStyle(
                                    backgroundColor: ButtonState.all(yellow),
                                  ),
                                  child: const MyText(
                                      color: white,
                                      size: 14,
                                      text: "Adjust Duration"),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ContentDialog(
                                          constraints: const BoxConstraints(
                                            maxHeight: 300,
                                            maxWidth: 400,
                                          ),
                                          actions: [
                                            Button(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    ButtonState.all(yellow),
                                              ),
                                              child: const Text(
                                                "Close",
                                                style: TextStyle(
                                                  color: white,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigate.back(context);
                                              },
                                            ),
                                            Button(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    ButtonState.all(green),
                                              ),
                                              child: const Text(
                                                "Update",
                                                style: TextStyle(
                                                  color: white,
                                                ),
                                              ),
                                              onPressed: () {
                                                courseController
                                                    .handleUpdateExamDuration();
                                              },
                                            ),
                                          ],
                                          content: Column(
                                            children: [
                                              const Text(
                                                "Select Exam Duration",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        const Text("Hour(s)"),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        NumberBox(
                                                          max: 3,
                                                          min: 0,
                                                          onChanged:
                                                              (num? value) {
                                                            if (value == null) {
                                                              courseController
                                                                  .hr.value = 0;
                                                            } else {
                                                              courseController
                                                                      .hr
                                                                      .value =
                                                                  value.toInt();
                                                            }
                                                          },
                                                          value: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        const Text("Min(s)"),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        NumberBox(
                                                          max: 60,
                                                          min: 1,
                                                          onChanged:
                                                              (num? value) {
                                                            if (value == null) {
                                                              courseController
                                                                  .mins
                                                                  .value = 0;
                                                            } else {
                                                              courseController
                                                                      .mins
                                                                      .value =
                                                                  value.toInt();
                                                            }
                                                          },
                                                          value: 0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 4.3,
                            height: 160,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: blue,
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
                              children: [
                                const CircleAvatar(
                                    backgroundColor: yellow,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(FluentIcons.questionnaire),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyText(
                                    color: white,
                                    size: 26,
                                    text: courseController.results.length
                                        .toString()),
                                const SizedBox(
                                  height: 10,
                                ),
                                const MyText(
                                    color: white,
                                    size: 14,
                                    text: "submitted results"),
                                const SizedBox(
                                  height: 10,
                                ),
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
