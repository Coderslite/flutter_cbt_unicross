import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';

import '../models/user_model.dart';

Future<List<UserModel>> getAllStudents() async {
  var response = await http.get(Uri.parse("$baseUrl/students"));
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List courses = responseData['data'];
    return courses.map((e) => UserModel.fromJson(e)).toList();
  } else {
    throw Exception("something went wrong");
  }
}
