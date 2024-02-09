import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';

import '../models/course_model.dart';

Future<List<CourseModel>> getLecturerCourses() async {
  var prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('userId');
  var response =
      await http.get(Uri.parse("$baseUrl/courses/lecturer-courses/$userId"));
  var responseData = jsonDecode(response.body);
  List courses = responseData['data'];
  return courses.map((e) => CourseModel.fromJson(e)).toList();
}
