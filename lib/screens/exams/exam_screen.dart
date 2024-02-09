import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/controllers/exam_questions_controllers.dart';
import 'package:unicross_cbt_desktop_app/models/exam_question_models.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import 'package:unicross_cbt_desktop_app/utilities/navigation.dart';

import 'exam_question.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  CourseController courseController = Get.put(CourseController());
  ExamQuestionsController examQuestionsController =
      Get.put(ExamQuestionsController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // examQuestionsController.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var widthSize = MediaQuery.of(context).size.width - 260;
    // var heightSize = MediaQuery.of(context).size.width - 260;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.07,
          image: AssetImage("assets/images/logo.png"),
        ),
      ),
      child: Obx(
        () => courseController.courseModel.value == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Course: ${courseController.sCourseTitle}"),
                  const Text("No Course Selected Yet"),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   // decoration: BoxDecoration(
                  //   //     gradient: LinearGradient(
                  //   //         colors: [darkBlue!, black!], begin: Alignment.topLeft)),
                  //   color: black,
                  //   height: 60,
                  //   alignment: Alignment.center,
                  //   width: double.infinity,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             "GSS 1101",
                  //             style: TextStyle(
                  //               fontSize: 20,
                  //               color: white,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             "Use of English and Library Skills",
                  //             style: TextStyle(
                  //               fontSize: 15,
                  //               color: white,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${examQuestionsController.setTimeMinutes} mins : ${examQuestionsController.setTimeSeconds} secs",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Button(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: const [
                                    Icon(FluentIcons.calculator),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Calculator"),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return ContentDialog(
                                          content: SimpleCalculator(
                                        value: 0,
                                        hideExpression: false,
                                        onChanged: (key, value, expression) {
                                          /*...*/
                                        },
                                        theme: const CalculatorThemeData(
                                          displayColor: Colors.black,
                                          displayStyle: TextStyle(
                                              fontSize: 80, color: blue),
                                        ),
                                      ));
                                    });
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Button(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ContentDialog(
                                        constraints: const BoxConstraints(
                                          maxHeight: 250,
                                          maxWidth: 300,
                                        ),
                                        title: const Text("Confirmation"),
                                        actions: [
                                          Button(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      ButtonState.all(red)),
                                              onPressed: () {
                                                Navigate.back(context);
                                              },
                                              child: const Text(
                                                "No",
                                                style: TextStyle(color: white),
                                              )),
                                          Button(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      ButtonState.all(green)),
                                              onPressed: () {
                                                examQuestionsController
                                                    .handleSubmit(context);
                                              },
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(color: white),
                                              ))
                                        ],
                                        content: Column(
                                          children: const [
                                            Text(
                                                "Are you sure you want to submit"),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              style: ButtonStyle(
                                backgroundColor: ButtonState.all(green),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Answer all Questions",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    key: UniqueKey(),
                    child: PageView.builder(
                        key: UniqueKey(),
                        onPageChanged: (value) {
                          examQuestionsController.index.value = value;
                        },
                        itemCount: examQuestionsController.questions.length,
                        itemBuilder: (context, index) {
                          ExamQuestionModel question = examQuestionsController
                              .questions[examQuestionsController.index.toInt()];

                          var options = question.options == ''
                              ? []
                              : jsonDecode(question.options);
                          return ExamQuestion(
                            index: examQuestionsController.index.toInt(),
                            question: question.question,
                            options: options,
                            type: question.type,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Button(
                            onPressed: () {
                              examQuestionsController.index < 1
                                  ? null
                                  : examQuestionsController
                                      .handlePreviousQuestion();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    examQuestionsController.index < 1
                                        ? ButtonState.all(black)
                                        : ButtonState.all(blue)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Previous",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                itemCount:
                                    examQuestionsController.questions.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 50),
                                itemBuilder: (context, index) {
                                  return Button(
                                    onPressed: () {
                                      examQuestionsController
                                          .handleChangeQuestion(index);
                                    },
                                    child: Container(
                                      // margin: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: examQuestionsController
                                                    .index.value ==
                                                index
                                            ? green
                                            : examQuestionsController
                                                        .answers[index]
                                                        .toString() ==
                                                    '1'
                                                ? red
                                                : blue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),

                                      child: Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(color: white),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Button(
                            onPressed: () {
                              examQuestionsController.index >=
                                      examQuestionsController.questions.length -
                                          1
                                  ? null
                                  : examQuestionsController
                                      .handleNextQuestion();
                            },
                            style: ButtonStyle(
                              backgroundColor: examQuestionsController.index >=
                                      examQuestionsController.questions.length -
                                          1
                                  ? ButtonState.all(black)
                                  : ButtonState.all(blue),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Next",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
