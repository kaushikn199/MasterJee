class ScheduleResponse {
  final String status;
  final String message;
  final bool result;
  final List<ScheduleData> data;

  ScheduleResponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,
  });

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ScheduleData.fromJson(e))
          .toList(),
    );
  }
}

class ScheduleData {
  final String id;
  final String totalWorkingDays;
  final String cbseTermId;
  final String cbseTermGroupId;
  final String cbseExamAssessmentId;
  final String cbseExamGradeId;
  final String name;
  final String promoteClass;
  final String? examCode;
  final String sessionId;
  final String description;
  final String? combinedEw;
  final String isPublish;
  final String isActive;
  final String createdBy;
  final String useExamRollNo;
  final String createdAt;
  final List<TimeTable> timeTable;

  ScheduleData({
    required this.id,
    required this.totalWorkingDays,
    required this.cbseTermId,
    required this.cbseTermGroupId,
    required this.cbseExamAssessmentId,
    required this.cbseExamGradeId,
    required this.name,
    required this.promoteClass,
    required this.examCode,
    required this.sessionId,
    required this.description,
    required this.combinedEw,
    required this.isPublish,
    required this.isActive,
    required this.createdBy,
    required this.useExamRollNo,
    required this.createdAt,
    required this.timeTable,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    return ScheduleData(
      id: json['id'] ?? '',
      totalWorkingDays: json['total_working_days'] ?? '',
      cbseTermId: json['cbse_term_id'] ?? '',
      cbseTermGroupId: json['cbse_term_group_id'] ?? '',
      cbseExamAssessmentId: json['cbse_exam_assessment_id'] ?? '',
      cbseExamGradeId: json['cbse_exam_grade_id'] ?? '',
      name: json['name'] ?? '',
      promoteClass: json['promote_class'] ?? '',
      examCode: json['exam_code'],
      sessionId: json['session_id'] ?? '',
      description: json['description'] ?? '',
      combinedEw: json['combined_ew'],
      isPublish: json['is_publish'] ?? '',
      isActive: json['is_active'] ?? '',
      createdBy: json['created_by'] ?? '',
      useExamRollNo: json['use_exam_roll_no'] ?? '',
      createdAt: json['created_at'] ?? '',
      timeTable: (json['time_table'] as List<dynamic>? ?? [])
          .map((e) => TimeTable.fromJson(e))
          .toList(),
    );
  }
}

class TimeTable {
  final String id;
  final String cbseExamId;
  final String subjectId;
  final String date;
  final String timeFrom;
  final String timeTo;
  final String duration;
  final String roomNo;
  final String isWritten;
  final String writtenMaximumMarks;
  final String isPractical;
  final String? scholasticArea;
  final String? practicalMaximumMark;
  final String? createdBy;
  final String createdAt;
  final String subjectName;
  final String subjectCode;

  TimeTable({
    required this.id,
    required this.cbseExamId,
    required this.subjectId,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.duration,
    required this.roomNo,
    required this.isWritten,
    required this.writtenMaximumMarks,
    required this.isPractical,
    this.scholasticArea,
    this.practicalMaximumMark,
    this.createdBy,
    required this.createdAt,
    required this.subjectName,
    required this.subjectCode,
  });

  factory TimeTable.fromJson(Map<String, dynamic> json) {
    return TimeTable(
      id: json['id'] ?? '',
      cbseExamId: json['cbse_exam_id'] ?? '',
      subjectId: json['subject_id'] ?? '',
      date: json['date'] ?? '',
      timeFrom: json['time_from'] ?? '',
      timeTo: json['time_to'] ?? '',
      duration: json['duration'] ?? '',
      roomNo: json['room_no'] ?? '',
      isWritten: json['is_written'] ?? '',
      writtenMaximumMarks: json['written_maximum_marks'] ?? '',
      isPractical: json['is_practical'] ?? '',
      scholasticArea: json['scholastic_area']?.toString(),
      practicalMaximumMark: json['practical_maximum_mark']?.toString(),
      createdBy: json['created_by']?.toString(),
      createdAt: json['created_at'] ?? '',
      subjectName: json['subject_name'] ?? '',
      subjectCode: json['subject_code'] ?? '',
    );
  }
}