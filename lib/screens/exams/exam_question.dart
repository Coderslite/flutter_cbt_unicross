import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/exam_questions_controllers.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';

import '../../utilities/text.dart';

class ExamQuestion extends StatefulWidget {
  final String question;
  final List options;
  final int index;
  final String type;

  const ExamQuestion({
    Key? key,
    required this.question,
    required this.options,
    required this.index,
    required this.type,
  }) : super(key: key);

  @override
  State<ExamQuestion> createState() => _ExamQuestionState();
}

class _ExamQuestionState extends State<ExamQuestion> {
  ExamQuestionsController examQuestionsController =
      Get.put(ExamQuestionsController());
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: black,
      color: white,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: widget.question,
              color: Colors.black,
              size: 24,
            ),
            const SizedBox(height: 10),
            if (widget.type == 'sub')
              Form(
                key: _formKey,
                child: TextFormField(
                  initialValue:
                      examQuestionsController.answers[widget.index] == '1'
                          ? ''
                          : examQuestionsController.answers[widget.index],
                  onChanged: (value) {
                    setState(() {
                      examQuestionsController.answers[widget.index] = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Type Answer Here....",
                  ),
                ),
              )
            else
              Column(
                children: [
                  for (int index = 0; index < widget.options.length; index++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RadioListTile<String>(
                        value: widget.options[index],
                        groupValue:
                            examQuestionsController.answers[widget.index],
                        onChanged: (val) {
                          setState(() {
                            examQuestionsController.answers[widget.index] =
                                val!;
                          });
                        },
                        title: MyText(
                          text: widget.options[index],
                          color: examQuestionsController
                                      .answers[widget.index] ==
                                  '1'
                              ? Colors.black
                              : examQuestionsController.answers[widget.index] ==
                                      widget.options[index]
                                  ? Colors.blue
                                  : Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
