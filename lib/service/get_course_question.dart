import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';
import 'package:unicross_cbt_desktop_app/models/exam_question_models.dart';

Future<List<ExamQuestionModel>> getCourseQuestion(String courseId) async {
  var response = await http.get(Uri.parse("$baseUrl/exams/$courseId"));
  var responseData = jsonDecode(response.body);
  List questions = responseData['questions'];
  return questions.map((e) => ExamQuestionModel.fromJson(e)).toList();
}
