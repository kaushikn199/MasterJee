class AssessmentResponse {
  final String status;
  final String message;
  final bool result;
  final List<AssessmentModel> data;

  AssessmentResponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,
  });

  factory AssessmentResponse.fromJson(Map<String, dynamic> json) {
    return AssessmentResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AssessmentModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class AssessmentModel {
  final String id;
  final String name;
  final String description;
  final List<AssessmentTypeModel> types;

  AssessmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.types,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => AssessmentTypeModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class AssessmentTypeModel {
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

  AssessmentTypeModel({
    required this.id,
    required this.cbseExamAssessmentId,
    this.scholasticArea,
    this.isForGrade,
    required this.name,
    required this.code,
    required this.maximumMarks,
    required this.passPercentage,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  factory AssessmentTypeModel.fromJson(Map<String, dynamic> json) {
    return AssessmentTypeModel(
      id: json['id'] ?? '',
      cbseExamAssessmentId: json['cbse_exam_assessment_id'] ?? '',
      scholasticArea: json['scholastic_area'],
      isForGrade: json['is_for_grade'],
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      maximumMarks: json['maximum_marks'] ?? '0',
      passPercentage: json['pass_percentage'] ?? '0',
      description: json['description'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}


