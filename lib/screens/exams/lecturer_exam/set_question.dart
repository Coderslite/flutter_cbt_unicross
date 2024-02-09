import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

import '../../../controllers/course_controller.dart';
import '../../../controllers/set_question_controller.dart';
import '../../../models/exam_question_models.dart';
import '../../../utilities/color.dart';

class SetQuestion extends StatefulWidget {
  const SetQuestion({
    super.key,
  });

  @override
  State<SetQuestion> createState() => _SetQuestionState();
}

class _SetQuestionState extends State<SetQuestion> {
  List<TextEditingController> optionListController = [];
  // int optionLength = 0;
  int checkedAnswer = 10;
  String question = '';
  String answer = '';
  handleAddOption() {
    setState(() {
      // optionLength++;
      optionListController.add(TextEditingController());
    });
  }

  handleRemoveOption(int index) {
    print(index);
    setState(() {
      optionListController.removeAt(index);
      // optionLength--;
    });
  }

  SetQuestionController setQuestionController =
      Get.put(SetQuestionController());
  CourseController courseController = Get.put(CourseController());
  // List<MenuFlyoutItem> get dropdownItems {
  //   List<MenuFlyoutItem> menuItems =  [
  //     MenuFlyoutItem(value: "obj", child: Text("OBJ")),
  //     MenuFlyoutItem(value: "sub", child: Text("SUB")),
  //   ];
  //   return menuItems;
  // }

  String questionType = "obj";
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text("Add Question"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: DropDownButton(
                leading: const Icon(FluentIcons.survey_questions),
                title: Text(questionType == 'obj' ? 'Objective' : 'Subjective'),
                items: [
                  MenuFlyoutItem(
                    text: const Text("Objective"),
                    onPressed: () {
                      setState(() {
                        questionType = 'obj';
                      });
                    },
                  ),
                  MenuFlyoutItem(
                    text: const Text("Subjective"),
                    onPressed: () {
                      setState(() {
                        questionType = 'sub';
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextBox(
              maxLines: 8,
              minLines: 1,
              onChanged: (val) {
                setState(() {
                  question = val;
                });
              },
              placeholder: "Enter Question",
              decoration: const BoxDecoration(),
            ),
            const SizedBox(
              height: 20,
            ),
            questionType == 'obj'
                ? Column(
                    children: [
                      for (int y = 0; y < optionListController.length; y++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Button(
                                onPressed: () {
                                  handleRemoveOption(y);
                                },
                                child: CircleAvatar(
                                  backgroundColor: red,
                                  radius: 10,
                                  child: Icon(
                                    FluentIcons.remove,
                                    size: 10,
                                    color: white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextBox(
                                  controller: optionListController[y],
                                  placeholder: "Option ${y + 1}",
                                ),
                              ),
                              y == checkedAnswer
                                  ? Button(
                                      onPressed: () {
                                        setState(() {
                                          checkedAnswer = y;
                                          answer = optionListController[y].text;
                                        });
                                      },
                                      child:
                                          const Icon(FluentIcons.checkbox_fill))
                                  : Button(
                                      onPressed: () {
                                        setState(() {
                                          checkedAnswer = y;
                                          answer = optionListController[y].text;
                                        });
                                      },
                                      child: const Icon(FluentIcons.checkbox))
                            ],
                          ),
                        ),
                    ],
                  )
                : TextBox(
                    onChanged: (value) {
                      setState(() {
                        answer = value;
                      });
                    },
                    placeholder: "Enter Answer",
                    decoration: const BoxDecoration(),
                  ),
            questionType == 'obj'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button(
                        onPressed: () {
                          handleAddOption();
                        },
                        child: const CircleAvatar(
                          radius: 10,
                          child: Center(
                              child: Icon(
                            FluentIcons.add,
                            size: 12,
                          )),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      actions: [
        Button(
          style: ButtonStyle(backgroundColor: ButtonState.all(red)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Close",
            style: TextStyle(
              color: white,
            ),
          ),
        ),
        Button(
          style: ButtonStyle(backgroundColor: ButtonState.all(green)),
          onPressed: () {
            handleAddQuestion();
          },
          child: Text(
            "Add",
            style: TextStyle(
              color: white,
            ),
          ),
        ),
      ],
    );
  }

  handleAddQuestion() {
    List options = [];
    if (answer == '') {
      BotToast.showSimpleNotification(
          title: 'Please select answer to question', backgroundColor: red);
    } else {
      for (var element in optionListController) {
        options.add(element.text);
      }
      setQuestionController.questionList.add(ExamQuestionModel(
          id: UniqueKey().toString(),
          question: question,
          options: jsonEncode(options),
          answer: answer,
          type: questionType,
          course: courseController.sCourseId.value));
    }
  }
}
