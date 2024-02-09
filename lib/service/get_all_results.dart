import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';
import 'package:unicross_cbt_desktop_app/models/result_model.dart';

Future<List<ResultModel>> getAllResult(String courseId) async {
  var response = await http.get(Uri.parse("$baseUrl/results/$courseId"));
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List courses = responseData['data'];
    return courses.map((e) => ResultModel.fromJson(e)).toList();
  } else {
    throw Exception("something went wrong");
  }
}
