import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/exam_questions_controllers.dart';
import 'package:unicross_cbt_desktop_app/models/exam_question_models.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';

class ExamQuestions extends StatefulWidget {
  const ExamQuestions({Key? key}) : super(key: key);

  @override
  State<ExamQuestions> createState() => _ExamQuestionsState();
}

class _ExamQuestionsState extends State<ExamQuestions> {
  ExamQuestionsController examQuestionsController =
      Get.put(ExamQuestionsController());

  @override
  void initState() {
    examQuestionsController.handleGetExamQuestions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Text(
                  "Uploaded Questions",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: Text(
                    "Delete All",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            Expanded(
              child: examQuestionsController.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : examQuestionsController.questions.isEmpty
                      ? const Center(child: Text("No Questions Available"))
                      : ListView.builder(
                          itemCount: examQuestionsController.questions.length,
                          itemBuilder: (context, index) {
                            ExamQuestionModel question =
                                examQuestionsController.questions[index];
                            var a = question.options;
                            List options = question.options == ''
                                ? []
                                : jsonDecode(a.toString());
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      title: Text(
                                        question.question,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      trailing: examQuestionsController
                                              .isDeleting.isTrue
                                          ? const Text("Deleting...")
                                          : IconButton(
                                              onPressed: () {
                                                examQuestionsController
                                                    .handleDeleteQuestion(
                                                        question.id,context);
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red),
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
                                                    fontSize: 16,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(
                                            height: options.length * 50.0,
                                            child: ListView.builder(
                                              itemCount: options.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: options[index] ==
                                                          question.answer
                                                      ? const Icon(
                                                          Icons
                                                              .radio_button_checked,
                                                          color: Colors.blue)
                                                      : const Icon(Icons
                                                          .radio_button_unchecked),
                                                  title: Text(
                                                    options[index].toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
