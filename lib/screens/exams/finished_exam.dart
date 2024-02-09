import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:unicross_cbt_desktop_app/controllers/exam_questions_controllers.dart';
import 'package:unicross_cbt_desktop_app/screens/auth/login_screen.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import 'package:unicross_cbt_desktop_app/utilities/navigation.dart';
import 'package:unicross_cbt_desktop_app/utilities/text.dart';

class FinishedExam extends StatefulWidget {
  const FinishedExam({super.key});

  @override
  State<FinishedExam> createState() => _FinishedExamState();
}

class _FinishedExamState extends State<FinishedExam> {
  ExamQuestionsController examQuestionsController =
      Get.put(ExamQuestionsController());
  @override
  void initState() {
    examQuestionsController.stopTimer();
    // examQuestionsController.index.value = 0;
    super.initState();
  }

  @override
  void dispose() {
    examQuestionsController.answers.value = [];
    examQuestionsController.questions.value = [];
    examQuestionsController.failedQuestions = [];
    examQuestionsController.correctQuestions = [];
    examQuestionsController.score.value = 0;
    examQuestionsController.percentage.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: examQuestionsController.percentage.value / 100,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${examQuestionsController.score} pts",
                  style: const TextStyle(
                      color: white, fontSize: 25, fontWeight: FontWeight.w500),
                ),
                MyText(
                    color: white,
                    size: 42,
                    text: "${examQuestionsController.percentage.value}%"),
              ],
            ),
            progressColor: Colors.green,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Percentage Scored",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Button(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return ContentDialog(
                        constraints: const BoxConstraints(maxWidth: 500),
                        actions: [
                          Button(
                            style: ButtonStyle(
                                backgroundColor: ButtonState.all(red)),
                            onPressed: () {
                              Navigate.back(context);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(color: white),
                            ),
                          )
                        ],
                        title: const Text(
                          "Failed Questions",
                          style: TextStyle(
                            color: red,
                          ),
                        ),
                        content: Column(
                          children: [
                            for (int x = 0;
                                x <
                                    examQuestionsController
                                        .failedQuestions.length;
                                x++)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        child: Center(
                                          child: Text((examQuestionsController
                                                      .failedQuestions[x] +
                                                  1)
                                              .toString()),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 430,
                                        child: Text(
                                          examQuestionsController
                                              .questions[examQuestionsController
                                                  .failedQuestions[x]]
                                              .question,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Answer : ",
                                        style: TextStyle(
                                            color: blue,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        examQuestionsController
                                            .questions[examQuestionsController
                                                .failedQuestions[x]]
                                            .answer,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Your Choice: ",
                                        style: TextStyle(color: red),
                                      ),
                                      Text(
                                        examQuestionsController.answers[
                                                        examQuestionsController
                                                            .failedQuestions[x]]
                                                    .toString() ==
                                                '1'
                                            ? 'Skipped'
                                            : examQuestionsController.answers[
                                                    examQuestionsController
                                                        .failedQuestions[x]]
                                                .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                          ],
                        ),
                      );
                    });
              },
              child: Text(
                  "Failed ${examQuestionsController.failedQuestions.length} questions")),
          const SizedBox(
            height: 20,
          ),
          Button(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return ContentDialog(
                        title: const Text("Correct Questions"),
                        constraints: const BoxConstraints(maxWidth: 500),
                        style: ContentDialogThemeData.standard(
                            FluentThemeData.light()),
                        actions: [
                          Button(
                            style: ButtonStyle(
                                backgroundColor: ButtonState.all(red)),
                            onPressed: () {
                              Navigate.back(context);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(color: white),
                            ),
                          )
                        ],
                        content: Column(
                          children: [
                            for (int x = 0;
                                x <
                                    examQuestionsController
                                        .correctQuestions.length;
                                x++)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        child: Center(
                                          child: Text((examQuestionsController
                                                      .correctQuestions[x] +
                                                  1)
                                              .toString()),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 430,
                                        child: Text(
                                          examQuestionsController
                                              .questions[examQuestionsController
                                                  .correctQuestions[x]]
                                              .question,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Ans: ",
                                        style: TextStyle(color: blue),
                                      ),
                                      Text(examQuestionsController
                                          .questions[examQuestionsController
                                              .correctQuestions[x]]
                                          .answer)
                                    ],
                                  )
                                ],
                              )
                          ],
                        ),
                      );
                    });
              },
              child: Text(
                  "Got ${examQuestionsController.correctQuestions.length} Correct Answer")),
          const SizedBox(
            height: 20,
          ),
          Button(
              onPressed: () {
                examQuestionsController.questions.value = [];
                examQuestionsController.answers.value = [];
                Navigate.forwardForever(context, const LoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Go Home"),
                ],
              ))
        ],
      ),
    );
  }
}
