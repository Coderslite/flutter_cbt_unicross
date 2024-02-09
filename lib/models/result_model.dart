class ResultModel {
  String? id;
  String? courseId;
  dynamic student;
  String? score;
  String? createdAt;

  ResultModel({
    this.id,
    this.courseId,
    this.student,
    this.score,
    this.createdAt,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['_id'],
      courseId: json['courseId'],
      student: json['studentId'],
      score: json['score'],
      createdAt: json['createdAt'],
    );
  }
}
