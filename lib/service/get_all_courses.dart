import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';
import 'package:unicross_cbt_desktop_app/models/course_model.dart';

Future<List<CourseModel>> getAllCourses() async {
  var response = await http.get(Uri.parse("$baseUrl/courses"));
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List courses = responseData['message'];
    return courses.map((e) => CourseModel.fromJson(e)).toList();
  } else {
    throw Exception("something went wrong");
  }
}
