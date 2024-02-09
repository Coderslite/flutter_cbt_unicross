class ExamQuestionModel {
  String id;
  String question;
  String options;
  String answer;
  String type;
  String course;

  ExamQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
    required this.type,
    required this.course,
  });

  toMap() => {
        ExamQuestionModel(
          id: id,
          question: question,
          options: options,
          answer: answer,
          type: type,
          course: course,
        )
      };

  factory ExamQuestionModel.fromJson(Map<String, dynamic> json) {
    return ExamQuestionModel(
      id: json['_id'],
      question: json['question'],
      options: json['options'],
      answer: json['answer'],
      type: json['type'],
      course: json['course']
    );
  }
}
