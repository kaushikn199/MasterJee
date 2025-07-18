class ExamScoreResponse {
  final String status;
  final String message;
  final List<ExamScoreData> data;
  final bool result;

  ExamScoreResponse({
    this.status = "",
    this.message = "",
    this.data = const [],
    this.result = false,
  });

  factory ExamScoreResponse.fromJson(Map<String, dynamic> json) {
    return ExamScoreResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExamScoreData.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class ExamScoreData {
  final String studentId;
  final String examStudentId;
  final String studentName;
  final String notes;
  final List<AssessmentScoreData> assessmentScores;

  ExamScoreData({
    this.studentId = "",
    this.examStudentId = "",
    this.studentName = "",
    this.notes = "",
    this.assessmentScores = const [],
  });

  factory ExamScoreData.fromJson(Map<String, dynamic> json) {
    return ExamScoreData(
      studentId: json['student_id'] ?? "",
      examStudentId: json['exam_student_id'] ?? "",
      studentName: json['student_name'] ?? "",
      notes: json['notes'] ?? "",
      assessmentScores: (json['assessment_scores'] as List<dynamic>?)
          ?.map((e) => AssessmentScoreData.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class AssessmentScoreData {
  final String examTimetableId;
  final String assessmentTypeId;
  final String assessmentId;
  final String assessmentName;
  final String maxScore;
  final String? score;

  AssessmentScoreData({
    this.examTimetableId = "",
    this.assessmentTypeId = "",
    this.assessmentId = "",
    this.assessmentName = "",
    this.maxScore = "",
    this.score,
  });

  factory AssessmentScoreData.fromJson(Map<String, dynamic> json) {
    return AssessmentScoreData(
      examTimetableId: json['exam_timetable_id'] ?? "",
      assessmentTypeId: json['assessment_type_id'] ?? "",
      assessmentId: json['assessment_id'] ?? "",
      assessmentName: json['assessment_name'] ?? "",
      maxScore: json['max_score'] ?? "",
      score: json['score']?.toString(),
    );
  }
}