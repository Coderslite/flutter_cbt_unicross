import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicross_cbt_desktop_app/controllers/course_controller.dart';
import 'package:unicross_cbt_desktop_app/controllers/exam_questions_controllers.dart';
import 'package:unicross_cbt_desktop_app/controllers/login_controller.dart';
import 'package:unicross_cbt_desktop_app/controllers/profile_controller.dart';
import 'package:unicross_cbt_desktop_app/screens/dashboard/dashboard.dart';
import 'package:unicross_cbt_desktop_app/screens/exams/exam_screen.dart';
import 'package:unicross_cbt_desktop_app/screens/results/results.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';

import '../../utilities/text.dart';
import '../admin/all_courses.dart';
import '../admin/all_lecturer.dart';
import '../admin/all_students.dart';
import '../dashboard/admin_dashboard.dart';
import '../exams/lecturer_exam/exam_questions.dart';
import '../exams/lecturer_exam/upload_exam_questions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  ProfileController profileController = Get.put(ProfileController());
  CourseController courseController = Get.put(CourseController());
  ExamQuestionsController examController = Get.put(ExamQuestionsController());
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          height: 40,
          title: const MyText(
              color: white,
              size: 24,
              text:
                  "KIOSK CBT SYSTEM FOR UNICROSS BUILT BY OSSAI ABRAHAM (18/CSC/001)"),
          actions: Button(
              style: ButtonStyle(backgroundColor: ButtonState.all(red)),
              child: const MyText(color: white, size: 14, text: "Logout"),
              onPressed: () {})),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.compact,
        size: const NavigationPaneSize(openWidth: 300),
        scrollBehavior: const FluentScrollBehavior(),
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                profileController.profileType.value == 'admin'
                    ? const MyText(
                        color: white, size: 20, text: "Admin Dashboard")
                    : const MyText(
                        color: white,
                        text: "Select Course",
                        size: 14,
                      ),
                const SizedBox(
                  height: 10,
                ),
                profileController.profileType.value == 'admin'
                    ? Container()
                    : profileController.profileType.value == 'lecturer'
                        ? courseController.courses.isEmpty
                            ? Container()
                            : DropDownButton(
                                leading: const Icon(FluentIcons.book_answers),
                                title: SizedBox(
                                  width: MediaQuery.of(context).size.width / 11,
                                  child: MyText(
                                    text: courseController.lCourseTitle.value ==
                                            ''
                                        ? 'Select Course'
                                        : courseController.lCourseTitle.value,
                                    color: black!,
                                    size: 17,
                                  ),
                                ),
                                items: courseController.courses
                                    .map((element) => MenuFlyoutItem(
                                          text: Text(
                                              element.courseTitle.toString()),
                                          onPressed: () {
                                            setState(() {
                                              courseController.lCourseId.value =
                                                  element.id;
                                              courseController.lCourseTitle
                                                  .value = element.courseTitle;
                                              courseController
                                                  .handleGetSingleCourse();
                                              courseController
                                                  .handleGetResults(element.id);
                                            });
                                          },
                                        ))
                                    .toList(),
                              )
                        : courseController.studentCourses.isEmpty
                            ? Container()
                            : DropDownButton(
                                leading: const Icon(FluentIcons.book_answers),
                                title: Text(
                                  courseController.sCourseTitle.value == ''
                                      ? 'Select Course'
                                      : courseController.sCourseTitle.value,
                                ),
                                items: courseController.studentCourses
                                    .map((element) => MenuFlyoutItem(
                                          text: MyText(
                                            text:
                                                element.courseTitle.toString(),
                                            size: 16,
                                            color: black!,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              courseController.sCourseId.value =
                                                  element.id;
                                              courseController.sCourseTitle
                                                  .value = element.courseTitle;
                                              courseController
                                                  .handleGetSingleCourse();
                                              examController
                                                  .handleGetExamQuestions(
                                                      context);
                                            });
                                          },
                                        ))
                                    .toList(),
                              ),
              ],
            ),
          ),
        ),
        selected: index,
        indicator: const StickyNavigationIndicator(
          color: white,
        ),
        onChanged: (value) {
          setState(() {
            index = value;
          });
        },
        footerItems: [
          PaneItem(
            tileColor: ButtonState.all(red),
            mouseCursor: MouseCursor.defer,
            onTap: () {
              loginController.handleLogout(context);
            },
            icon: const Icon(
              FluentIcons.sign_out,
              color: white,
            ),
            title: Text("Sign Out",
                style: GoogleFonts.metrophobic(
                    fontSize: 20.toDouble(), color: white)),
            body: Container(),
          ),
        ],
        items: profileController.profileType.value == 'lecturer'
            ? [
                PaneItem(
                  selectedTileColor: ButtonState.all(blue2),
                  icon: const Icon(FluentIcons.home),
                  title: Text("Home",
                      style: GoogleFonts.metrophobic(
                          fontSize: 20.toDouble(), color: white)),
                  body: const DashboardScreen(),
                  enabled:
                      courseController.lCourseId.value == '' ? false : true,
                ),
                PaneItem(
                  selectedTileColor: ButtonState.all(blue2),
                  icon: const Icon(FluentIcons.questionnaire),
                  title: Text("Set Questions",
                      style: GoogleFonts.metrophobic(
                          fontSize: 20.toDouble(), color: white)),
                  body: const UploadExamQuestions(),
                  enabled:
                      courseController.lCourseId.value == '' ? false : true,
                ),
                PaneItem(
                  selectedTileColor: ButtonState.all(blue2),
                  icon: const Icon(FluentIcons.survey_questions),
                  title: Text("View Question",
                      style: GoogleFonts.metrophobic(
                          fontSize: 20.toDouble(), color: white)),
                  body: const ExamQuestions(),
                  enabled:
                      courseController.lCourseId.value == '' ? false : true,
                ),
                PaneItem(
                  selectedTileColor: ButtonState.all(blue2),
                  icon: const Icon(FluentIcons.report_library),
                  title: Text("Results",
                      style: GoogleFonts.metrophobic(
                          fontSize: 20.toDouble(), color: white)),
                  body: ResultScreen(),
                  enabled:
                      courseController.lCourseId.value == '' ? false : true,
                ),
              ]
            : profileController.profileType.value == 'admin'
                ? [
                    PaneItem(
                      selectedTileColor: ButtonState.all(blue2),
                      icon: const Icon(FluentIcons.home),
                      title: Text("Dashboard",
                          style: GoogleFonts.metrophobic(
                              fontSize: 17.toDouble(), color: white)),
                      body: const AdminDashboard(),
                    ),
                    PaneItem(
                      selectedTileColor: ButtonState.all(blue2),
                      icon: const Icon(FluentIcons.learning_app),
                      title: Text("All Lecturers",
                          style: GoogleFonts.metrophobic(
                              fontSize: 17.toDouble(), color: white)),
                      body: const AllLecturers(),
                    ),
                    PaneItem(
                      selectedTileColor: ButtonState.all(blue2),
                      icon: const Icon(FluentIcons.people),
                      title: Text("All Students",
                          style: GoogleFonts.metrophobic(
                              fontSize: 17.toDouble(), color: white)),
                      body: const AllStudents(),
                    ),
                    PaneItem(
                      selectedTileColor: ButtonState.all(blue2),
                      icon: const Icon(FluentIcons.book_answers),
                      title: Text("All Courses",
                          style: GoogleFonts.metrophobic(
                              fontSize: 17.toDouble(), color: white)),
                      body: const AllCourses(),
                    ),
                  ]
                : [
                    PaneItem(
                      selectedTileColor: ButtonState.all(blue2),
                      icon: const Icon(FluentIcons.questionnaire),
                      title: const Text("Take Exam"),
                      body: const ExamScreen(),
                      enabled:
                          courseController.sCourseId.value == '' ? false : true,
                    ),
                  ],
      ),
    );
  }
}
