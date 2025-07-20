class AllExamAssessmentsResponse {
  final String status;
  final String message;
  final List<AssessmentData> data;
  final bool result;

  AllExamAssessmentsResponse({
    this.status = "",
    this.message = "",
    this.data = const [],
    this.result = false,
  });

  factory AllExamAssessmentsResponse.fromJson(Map<String, dynamic> json) {
    return AllExamAssessmentsResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AssessmentData.fromJson(e))
          .toList() ??
          [],
      result: json['result'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
      'result': result,
    };
  }
}

class AssessmentData {
  final String id;
  final String cbseExamAssessmentId;
  final String? scholasticArea;
  final String? isForGrade;
  final String name;
  final String code;
  final String maximumMarks;
  final String passPercentage;
  final String description;
  final String createdBy;
  final String createdAt;
   bool isChecked;

  AssessmentData({
    this.id = "",
    this.cbseExamAssessmentId = "",
    this.scholasticArea,
    this.isForGrade,
    this.name = "",
    this.code = "",
    this.maximumMarks = "",
    this.passPercentage = "",
    this.description = "",
    this.createdBy = "",
    this.createdAt = "",
    this.isChecked = false,
  });

  factory AssessmentData.fromJson(Map<String, dynamic> json) {
    return AssessmentData(
      id: json['id'] ?? "",
      cbseExamAssessmentId: json['cbse_exam_assessment_id'] ?? "",
      scholasticArea: json['scholastic_area'],
      isForGrade: json['is_for_grade'],
      name: json['name'] ?? "",
      code: json['code'] ?? "",
      maximumMarks: json['maximum_marks'] ?? "",
      passPercentage: json['pass_percentage'] ?? "",
      description: json['description'] ?? "",
      createdBy: json['created_by'] ?? "",
      createdAt: json['created_at'] ?? "",
      isChecked: json['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cbse_exam_assessment_id': cbseExamAssessmentId,
      'scholastic_area': scholasticArea,
      'is_for_grade': isForGrade,
      'name': name,
      'code': code,
      'maximum_marks': maximumMarks,
      'pass_percentage': passPercentage,
      'description': description,
      'created_by': createdBy,
      'created_at': createdAt,
      'isChecked': isChecked,
    };
  }
}
