import 'package:fluent_ui/fluent_ui.dart';

import '../../../utilities/color.dart';

class Question extends StatefulWidget {
  final String question;
  final List options;
  final String answer;
  final String type;
  const Question(
      {super.key,
      required this.question,
      required this.options,
      required this.answer,
      required this.type});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.question,
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
          ],
        ),
        widget.type == 'sub'
            ? Row(
                children: [
                  Text(
                    "Answer: ${widget.answer}",
                    style: TextStyle(
                        color: blue, fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ],
              )
            : SizedBox(
                height: widget.options.length * 50,
                child: ListView.builder(
                  itemCount: widget.options.length,
                  itemBuilder: (context, index) {
                    var option = widget.options[index];
                    return ListTile(
                      title: Text(option.toString()),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
