import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';

import '../models/course_model.dart';

Future<List<CourseModel>> getStudentCoursesById(String userId) async {
  var response =
      await http.get(Uri.parse("$baseUrl/courses/student-courses/$userId"));
  var responseData = jsonDecode(response.body);
  List courses = responseData['data'];
  return courses.map((e) => CourseModel.fromJson(e)).toList();
}
