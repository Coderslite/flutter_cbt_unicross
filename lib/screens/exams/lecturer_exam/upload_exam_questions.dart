import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/set_question_controller.dart';
import 'package:unicross_cbt_desktop_app/models/exam_question_models.dart';
import 'package:unicross_cbt_desktop_app/screens/exams/lecturer_exam/set_question.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import 'package:unicross_cbt_desktop_app/utilities/navigation.dart';

import 'each_question.dart';

class UploadExamQuestions extends StatefulWidget {
  const UploadExamQuestions({super.key});

  @override
  State<UploadExamQuestions> createState() => _UploadExamQuestionsState();
}

class _UploadExamQuestionsState extends State<UploadExamQuestions> {
  SetQuestionController setQuestionController =
      Get.put(SetQuestionController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(""),
                const Text(
                  "Set Questions for Exam",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Button(
                        child: Row(
                          children: [
                            Text(
                              "More Questions",
                              style: TextStyle(color: blue),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              FluentIcons.add,
                              color: blue,
                            )
                          ],
                        ),
                        onPressed: () {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return const SetQuestion();
                              });
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    Button(
                        child: Row(
                          children: [
                            Text(
                              "Upload Questions",
                              style: TextStyle(
                                color: green,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              FluentIcons.upload,
                              color: green,
                            )
                          ],
                        ),
                        onPressed: () {
                          setQuestionController.handleUploadQuestion(context);
                        }),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: setQuestionController.questionList.isEmpty
                    ? Center(
                        child: Text(
                          "No Questions",
                          style: TextStyle(color: black),
                        ),
                      )
                    : ListView.builder(
                        itemCount: setQuestionController.questionList.length,
                        itemBuilder: (context, index) {
                          ExamQuestionModel question =
                              setQuestionController.questionList[index];
                          var a = question.options;
                          List options = jsonDecode(a.toString());
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Text((index + 1).toString()),
                                    trailing: Button(
                                        child: Icon(
                                          FluentIcons.delete,
                                          color: red,
                                        ),
                                        onPressed: () {
                                          setQuestionController
                                              .handleRemoveQuestion(index);
                                        }),
                                    title: Text(
                                      question.question,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  question.type == 'sub'
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Answer: ${question.answer}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: blue,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          height: options.length * 50,
                                          child: ListView.builder(
                                              itemCount: options.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: options[index] ==
                                                          question.answer
                                                      ? Icon(
                                                          FluentIcons
                                                              .radio_btn_on,
                                                          color: blue,
                                                        )
                                                      : const Icon(FluentIcons
                                                          .radio_btn_off),
                                                  title: Text(options[index]
                                                      .toString()),
                                                );
                                              }),
                                        )
                                ],
                              ),
                            ),
                          );
                        })),
          ],
        ),
      ),
    );
  }
}
