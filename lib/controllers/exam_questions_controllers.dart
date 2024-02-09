import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/models/exam_question_models.dart';
import 'package:unicross_cbt_desktop_app/screens/exams/finished_exam.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import 'package:unicross_cbt_desktop_app/utilities/navigation.dart';

import '../service/get_course_question.dart';
import '../service/get_questions.dart';
import 'package:http/http.dart' as http;

import 'profile_controller.dart';

class ExamQuestionsController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  CourseController courseController = Get.put(CourseController());
  var isLoading = true.obs;
  var isDeleting = false.obs;
  var index = 0.obs;
  late Duration myDuration;
  Timer? timer;
  var setTimeHours = 0.obs;
  var setTimeMinutes = 0.obs;
  var setTimeSeconds = 0.obs;
  RxList questions = [].obs;
  RxList answers = [].obs;
  List failedQuestions = [].obs;
  List correctQuestions = [].obs;
  var score = 0.obs;
  var percentage = 0.0.obs;

  handleGetExamQuestions(context) async {
    // BotToast.showLoading();
    index.value = 0;
    questions.clear();
    answers.clear();
    isLoading.value = true;
    questions.value = await getCourseQuestion(
        profileController.profileType.value == 'lecturer'
            ? courseController.lCourseId.value
            : courseController.sCourseId.value);
    for (int x = 0; x < questions.length; x++) {
      answers.add('1');
    }
    profileController.profileType.value == 'admin' ||
            profileController.profileType.value == 'lecturer'
        ? null
        : startTimer(context);
    isLoading.value = false;
    // BotToast.closeAllLoading();
  }

  handleNextQuestion() {
    index.value++;
    update();
  }

  handlePreviousQuestion() {
    index.value--;
    update();
  }

  handleChangeQuestion(int idx) {
    index.value = idx;
    update();
  }

  startTimer(context) async {
    myDuration =
        Duration(seconds: courseController.courseModel.value!.examDuration!);
    update();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final mySeconds = myDuration.inSeconds - 1;
      if (mySeconds < 0 && timer.isActive) {
        timer.cancel();
        // WindowManager.instance.close();
        Navigate.forwardForever(context, const FinishedExam());
        stopTimer();
      } else {
        myDuration = Duration(seconds: mySeconds);
        setTimeHours.value = myDuration.inHours.remainder(24);
        setTimeMinutes.value = myDuration.inMinutes.remainder(60);
        setTimeSeconds.value = myDuration.inSeconds.remainder(60);
        // print(myDuration.inSeconds);
        update();
      }
    });
  }

  stopTimer() {
    timer!.cancel();
    setTimeHours.value = 0;
    setTimeMinutes.value = 0;
    setTimeSeconds.value = 0;
  }

// handle
  handleSubmit(BuildContext context) async {
    stopTimer();
    correctQuestions.clear();
    failedQuestions.clear();
    for (int x = 0; x < questions.length; x++) {
      ExamQuestionModel q = questions[x];
      if (q.answer.toLowerCase() == answers[x].toLowerCase()) {
        score.value = score.value + 1;
        correctQuestions.add(x);
      } else {
        score.value = score.value + 0;
        failedQuestions.add(x);
        print(failedQuestions);
      }
    }
    percentage.value = (score / questions.length) * 100;
    handleUploadResult(courseId: courseController.sCourseId.value);
    Navigate.forwardForever(context, const FinishedExam());
  }

  handleDeleteQuestion(String id, context) async {
    CourseController courseController = Get.put(CourseController());
    // BotToast.showLoading();
    isDeleting.value = true;
    try {
      var response = await http.delete(Uri.parse("$baseUrl/questions/$id"));
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        isDeleting.value = false;
        // BotToast.closeAllLoading();
        BotToast.showSimpleNotification(
            title: responseData['message'].toString(), backgroundColor: green);
        handleGetExamQuestions(context);
        courseController.handleGetCourseQuestions(false);
        update();
      } else {
        isDeleting.value = false;

        BotToast.closeAllLoading();
        BotToast.showSimpleNotification(
            title: responseData['message'].toString(), backgroundColor: red);
      }
    } catch (err) {
      isDeleting.value = false;
      // BotToast.closeAllLoading();
      BotToast.showSimpleNotification(
          title: err.toString(), backgroundColor: red);
    }
  }

  handleUploadResult({required String courseId}) async {
    var prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    try {
      var response = await http.post(Uri.parse("$baseUrl/results"), body: {
        "courseId": courseId,
        "studentId": "$userId",
        "score": "${score.value}",
      });
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        BotToast.showSimpleNotification(
            title: "Result Uploaded", backgroundColor: green);
      } else {
        BotToast.showSimpleNotification(
            title: responseData['message'].toString(), backgroundColor: red);
      }
    } catch (err) {
      print(err);
    }
  }
}
