class CourseModel {
  String? id;
  String? courseTitle;
  String? courseCode;
  int? examDuration;
  dynamic lecturer;
  String? createdAt;

  CourseModel(
      {this.id,
      this.courseTitle,
      this.courseCode,
      this.examDuration,
      this.lecturer,
      this.createdAt});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'],
      courseTitle: json['courseTitle'],
      courseCode: json['courseCode'],
      examDuration: json['examDuration'],
      lecturer: json['lecturer'],
      createdAt: json['createdAt'],
    );
  }
}
