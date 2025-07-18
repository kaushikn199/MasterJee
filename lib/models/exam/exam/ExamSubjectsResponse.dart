class ExamSubjectResponse {
  final String status;
  final String message;
  final List<ExamSubjectData> data;
  final bool result;

  ExamSubjectResponse({
    this.status = "",
    this.message = "",
    this.data = const [],
    this.result = false,
  });

  factory ExamSubjectResponse.fromJson(Map<String, dynamic> json) {
    return ExamSubjectResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExamSubjectData.fromJson(e))
          .toList() ??
          [],
      result: json['result'] ?? false,
    );
  }
}

class ExamSubjectData {
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
  final String name;
  final String code;
  final String type;
  final String isActive;
  final String linkedClass;
  final String? updatedAt;
  final String ttid;

  ExamSubjectData({
    this.id = "",
    this.cbseExamId = "",
    this.subjectId = "",
    this.date = "",
    this.timeFrom = "",
    this.timeTo = "",
    this.duration = "",
    this.roomNo = "",
    this.isWritten = "",
    this.writtenMaximumMarks = "",
    this.isPractical = "",
    this.scholasticArea,
    this.practicalMaximumMark,
    this.createdBy,
    this.createdAt = "",
    this.name = "",
    this.code = "",
    this.type = "",
    this.isActive = "",
    this.linkedClass = "",
    this.updatedAt,
    this.ttid = "",
  });

  factory ExamSubjectData.fromJson(Map<String, dynamic> json) {
    return ExamSubjectData(
      id: json['id'] ?? "",
      cbseExamId: json['cbse_exam_id'] ?? "",
      subjectId: json['subject_id'] ?? "",
      date: json['date'] ?? "",
      timeFrom: json['time_from'] ?? "",
      timeTo: json['time_to'] ?? "",
      duration: json['duration'] ?? "",
      roomNo: json['room_no'] ?? "",
      isWritten: json['is_written'] ?? "",
      writtenMaximumMarks: json['written_maximum_marks'] ?? "",
      isPractical: json['is_practical'] ?? "",
      scholasticArea: json['scholastic_area'],
      practicalMaximumMark: json['practical_maximum_mark'],
      createdBy: json['created_by'],
      createdAt: json['created_at'] ?? "",
      name: json['name'] ?? "",
      code: json['code'] ?? "",
      type: json['type'] ?? "",
      isActive: json['is_active'] ?? "",
      linkedClass: json['linked_class'] ?? "",
      updatedAt: json['updated_at'],
      ttid: json['ttid'] ?? "",
    );
  }
}
