import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';

import '../models/course_model.dart';

Future<CourseModel> getSingleCourse(String courseId) async {
  var response =
      await http.get(Uri.parse("$baseUrl/courses/$courseId"));
  var responseData = jsonDecode(response.body);
  var course = responseData['data'];
  return CourseModel.fromJson(course);
}
