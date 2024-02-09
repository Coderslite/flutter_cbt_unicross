// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:unicross_cbt_desktop_app/models/exam_question_models.dart';

// import '../constants/base_url.dart';

// Future<List<ExamQuestionModel>> getQuestion() async {
//   var response = await http.get(Uri.parse("$baseUrl/questions/"));
//   var responseData = jsonDecode(response.body);
//   if (responseData['status'] == true) {
//     List questions = responseData['data'];
//     return questions.map((e) => ExamQuestionModel.fromJson(e)).toList();
//   } else {
//     throw Exception(response.statusCode);
//   }
// }
