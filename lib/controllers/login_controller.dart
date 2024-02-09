// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/controllers/profile_controller.dart';
import 'package:unicross_cbt_desktop_app/screens/homepage/home.dart';
import 'package:http/http.dart' as http;
import 'package:unicross_cbt_desktop_app/utilities/color.dart';

import '../screens/auth/login_screen.dart';

class LoginController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  CourseController couseController = Get.put(CourseController());
  handleLogin(BuildContext context, String email, String password) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      BotToast.showLoading();
      var response = await http.post(Uri.parse("$baseUrl/auth/login"), body: {
        "email": email,
        "password": password,
      });
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        String type = responseData['role'].toString();
        var userId = responseData['userId'].toString();
        prefs.setString('userId', userId);
        if (type.toLowerCase() == 'lecturer') {
          profileController.profileType.value = 'lecturer';
          couseController.lCourseId.value = userId;
          await couseController.handleGetLecturerCoursers();
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const Home();
          }));
        } else if (type.toLowerCase() == 'user') {
          couseController.sCourseId.value = userId;
          profileController.profileType.value = 'student';
          await couseController.handleGetStudentCourses();
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const Home();
          }));
        } else {
          profileController.profileType.value = 'admin';
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const Home();
          }));
        }
        BotToast.showNotification(
          backgroundColor: green,
          title: (cancelFunc) {
            return const Text(
              "Login Successful",
              style: TextStyle(color: white),
            );
          },
        );
      } else {
        BotToast.showNotification(
          backgroundColor: red,
          title: (cancelFunc) {
            return const Text(
              "Incorrect email or password",
              style: TextStyle(color: white),
            );
          },
        );
      }
    } catch (err) {
      print(err);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  handleLogout(context) {
    couseController.courseModel.value = null;
    couseController.sCourseId.value = '';
    couseController.sCourseTitle.value = '';
    couseController.lCourseId.value = '';
    couseController.lCourseTitle.value = '';
    Navigator.pushReplacement(context, FluentPageRoute(builder: (_) {
      return const LoginScreen();
    }));
  }
}
