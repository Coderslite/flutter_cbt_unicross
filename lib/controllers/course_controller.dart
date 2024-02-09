import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';
import 'package:unicross_cbt_desktop_app/controllers/profile_controller.dart';
import 'package:unicross_cbt_desktop_app/utilities/navigation.dart';
import 'package:unicross_cbt_desktop_app/utilities/text.dart';

import '../models/course_model.dart';
import '../service/get_all_courses.dart';
import '../service/get_all_lecturers.dart';
import '../service/get_all_results.dart';
import '../service/get_all_students.dart';
import '../service/get_course_question.dart';
import '../service/get_lecturer_courses.dart';
import '../service/get_single_course.dart';
import 'package:http/http.dart' as http;

import '../service/get_student_courses.dart';
import '../service/get_student_courses_by_id.dart';
import '../utilities/color.dart';

class CourseController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  RxList courses = [].obs;
  RxList results = [].obs;
  RxList studentCourses = [].obs;
  var questions = [].obs;
  Rx<CourseModel?> courseModel = Rx(null);
  var loading = false.obs;
  var sCourseId = ''.obs;
  var sCourseTitle = ''.obs;
  var lCourseId = ''.obs;
  var lCourseTitle = ''.obs;
  var hr = 1.obs;
  var mins = 0.obs;

  var selectedCourse = {}.obs;

  var allcourses = [].obs;
  var allLecturers = [].obs;
  var allStudents = [].obs;

  handleGetLecturerCoursers() async {
    try {
      courses.value = await getLecturerCourses();
      update();
    } finally {
      loading.value = false;
    }
  }

  handleGetStudentCourses() async {
    try {
      studentCourses.value = await getStudentCourses();
      update();
    } finally {
      loading.value = false;
    }
  }

  handleGetStudentCoursesById(String userId) async {
    try {
      studentCourses.value = await getStudentCoursesById(userId);
      update();
    } finally {
      loading.value = false;
    }
  }

  handleGetSingleCourse() async {
    courseModel.value = await getSingleCourse(
        profileController.profileType.value == 'lecturer'
            ? lCourseId.value
            : sCourseId.value);
    handleGetCourseQuestions(false);
    update();
  }

  handleGetCourseQuestions(bool init) async {
    try {
      init == false ? BotToast.showLoading() : null;
      questions.value = await getCourseQuestion(
          profileController.profileType.value == 'lecturer'
              ? lCourseId.value
              : sCourseId.value);
      update();
    } finally {
      BotToast.closeAllLoading();
    }
  }

  handleUpdateExamDuration() async {
    try {
      BotToast.showLoading();
      var time = Duration(hours: hr.value, minutes: mins.value).inSeconds;
      var response = await http.put(Uri.parse("$baseUrl/courses"), body: {
        "examDuration": "$time",
        "courseId": "$lCourseId",
      });
      var responseData = jsonDecode(response.body);
      print(responseData);
      handleGetSingleCourse();
      BotToast.showNotification(
        backgroundColor: green,
        title: (cancelFunc) {
          return const Text(
            "Exam Duration Updated Successful",
            style: TextStyle(color: white),
          );
        },
      );
    } finally {
      BotToast.closeAllLoading();
    }
  }

// admin function
  handleGetAllCourses() async {
    allcourses.value = await getAllCourses();
    update();
  }

  handleGetAllLecturers() async {
    allLecturers.value = await getAllLecturers();
    update();
  }

  handleGetAllStudents() async {
    allStudents.value = await getAllStudents();
    update();
  }

  handleGetResults(String courseId) async {
    results.value = await getAllResult(courseId);
    update();
  }

  handleAssignCourseToLecture(
      String courseId, String lecturerId, context) async {
    try {
      var response =
          await http.put(Uri.parse("$baseUrl/courses/assign-course"), body: {
        "courseId": courseId,
        "lecturerId": lecturerId,
      });
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        BotToast.showNotification(
            title: (f) {
              return const MyText(
                color: white,
                size: 23,
                text: "Course Assigned to Lecturer",
              );
            },
            backgroundColor: green);
        handleGetAllCourses();
        Navigate.back(context);
      } else {
        BotToast.showNotification(
            title: (f) {
              return const MyText(
                color: white,
                size: 23,
                text: "Something went wrong",
              );
            },
            backgroundColor: red);
      }
    } catch (err) {}
  }

  handleAssignCourseToStudent(List courses, String studentId, context) async {
    try {
      for (var course in courses) {
        await http
            .put(Uri.parse("$baseUrl/courses/student-assign-course"), body: {
          "courseId": course.id,
          "studentId": studentId,
        });
      }

      handleGetStudentCoursesById(studentId);
      BotToast.showNotification(
          title: (f) {
            return const MyText(
              color: white,
              size: 23,
              text: "Course Added to Student Course List",
            );
          },
          backgroundColor: green);
      handleGetAllCourses();
    } catch (err) {
      BotToast.showNotification(
          title: (f) {
            return const MyText(
              color: white,
              size: 23,
              text: "Something went wrong",
            );
          },
          backgroundColor: red);
    }
  }

  handleRemoveStudentFromCourse(
      String courseId, String studentId, context) async {
    print(courseId);
    print(studentId);
    try {
      var response = await http
          .put(Uri.parse("$baseUrl/courses/remove-student-from-course"), body: {
        "courseId": courseId,
        "studentId": studentId,
      });

      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        handleGetStudentCoursesById(studentId);
        BotToast.showNotification(
            title: (f) {
              return const MyText(
                color: white,
                size: 23,
                text: "Course Removed From Student Course List",
              );
            },
            backgroundColor: green);
      } else {
        BotToast.showNotification(
            title: (f) {
              return const MyText(
                color: white,
                size: 23,
                text: "Something went wrong",
              );
            },
            backgroundColor: red);
      }
    } catch (err) {
      BotToast.showNotification(
          title: (f) {
            return MyText(
              color: white,
              size: 23,
              text: "$err",
            );
          },
          backgroundColor: red);
    }
  }

  handleAddLecturer({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      BotToast.showLoading();
      var response = await http.post(Uri.parse("$baseUrl/lecturer"), body: {
        "name": name,
        "email": email,
        "password": password,
        "role": "Lecturer"
      });
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        BotToast.showNotification(
          backgroundColor: green,
          title: (cancelFunc) {
            return const Text(
              "Lecturer Added",
              style: TextStyle(color: white),
            );
          },
        );
        handleGetAllLecturers();
      }
    } finally {
      handleGetAllLecturers();
      BotToast.closeAllLoading();
    }
  }

  handleAddStudent({
    required String name,
    required String regno,
    required String department,
    required String email,
    required String password,
  }) async {
    try {
      BotToast.showLoading();
      var response = await http.post(Uri.parse("$baseUrl/students"), body: {
        "name": name,
        "regno": regno,
        "department": department,
        "email": email,
        "password": password,
        "role": "User"
      });
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        BotToast.showNotification(
          backgroundColor: green,
          title: (cancelFunc) {
            return const Text(
              "Student Added",
              style: TextStyle(color: white),
            );
          },
        );
        handleGetAllStudents();
      }
    } finally {
      BotToast.closeAllLoading();
    }
  }

  handleDeleteLecturer({required String id}) async {
    try {
      BotToast.showLoading();
      var response = await http.delete(Uri.parse("$baseUrl/lecturer/$id"));
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        BotToast.showNotification(
          backgroundColor: green,
          title: (cancelFunc) {
            return const Text(
              "Lecturer Deleted",
              style: TextStyle(color: white),
            );
          },
        );
        handleGetAllLecturers();
      }
    } finally {
      BotToast.closeAllLoading();
    }
  }

  handleDeleteStudent({required String id}) async {
    try {
      BotToast.showLoading();
      var response = await http.delete(Uri.parse("$baseUrl/students/$id"));
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        BotToast.showNotification(
          backgroundColor: green,
          title: (cancelFunc) {
            return const Text(
              "Student Deleted",
              style: TextStyle(color: white),
            );
          },
        );
        handleGetAllStudents();
      }
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
