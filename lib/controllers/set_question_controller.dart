import 'package:bot_toast/bot_toast.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/constants/base_url.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';

import '../models/exam_question_models.dart';
import 'package:http/http.dart' as http;

import '../utilities/color.dart';

class SetQuestionController extends GetxController {
  RxList questionList = [].obs;
  RxInt hours = 1.obs;
  RxInt mins = 30.obs;

  handleAddQuestions(ExamQuestionModel question) async {
    questionList.add(question);
    update();
  }

  handleRemoveQuestion(int index) async {
    questionList.removeAt(index);
    update();
  }

  handleUploadQuestion(BuildContext context) async {
    CourseController courseController = Get.put(CourseController());
    try {
      BotToast.showLoading();
      var courseId = courseController.lCourseId.value;
      print(courseId);
      for (var element in questionList) {
        await http.post(Uri.parse("$baseUrl/questions"), body: {
          "question": element.question.toString(),
          "options": element.options,
          "type": element.type.toString(),
          "answer": element.answer.toString(),
          "course": courseId,
        });
      }
      BotToast.closeAllLoading();

      BotToast.showSimpleNotification(
          title: 'Successfully Uploaded', backgroundColor: green);
      questionList.value = [];
      courseController.handleGetCourseQuestions(false);
    } catch (err) {
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(
          title: err.toString(), backgroundColor: red);
    }
  }
}
