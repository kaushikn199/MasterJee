
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
     this.id = "",
     this.cbseExamAssessmentId = "",
    this.scholasticArea = "",
    this.isForGrade = "",
     this.name = "",
     this.code = "",
     this.maximumMarks = "",
     this.passPercentage = "",
     this.description = "",
     this.createdBy = "",
     this.createdAt = "",
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "cbse_exam_assessment_id": cbseExamAssessmentId,
    "scholastic_area": scholasticArea,
    "is_for_grade": isForGrade,
    "name": name,
    "code": code,
    "maximum_marks": maximumMarks,
    "pass_percentage": passPercentage,
    "description": description,
    "created_by": createdBy,
    "created_at": createdAt,
  };

}