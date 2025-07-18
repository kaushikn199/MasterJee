

class GradesInfoResponse {
  final String status;
  final String message;
  final bool result;
  final ExamGradeData? data;

  GradesInfoResponse({
    this.status = '',
    this.message = '',
    this.result = false,
    this.data,
  });

  factory GradesInfoResponse.fromJson(Map<String, dynamic> json) {
    return GradesInfoResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: json['data'] != null ? ExamGradeData.fromJson(json['data']) : null,
    );
  }
}

class ExamGradeData {
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final List<GradeRange> ranges;

  ExamGradeData({
    this.id = '',
    this.name = '',
    this.description = '',
    this.createdAt = '',
    this.ranges = const [],
  });

  factory ExamGradeData.fromJson(Map<String, dynamic> json) {
    return ExamGradeData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      ranges: (json['ranges'] as List<dynamic>? ?? [])
          .map((e) => GradeRange.fromJson(e))
          .toList(),
    );
  }
}

class GradeRange {
  final String id;
  final String cbseExamGradeId;
  final String name;
  final String minimumPercentage;
  final String maximumPercentage;
  final String description;
  final String createdBy;
  final String createdAt;

  GradeRange({
    this.id = '',
    this.cbseExamGradeId = '',
    this.name = '',
    this.minimumPercentage = '',
    this.maximumPercentage = '',
    this.description = '',
    this.createdBy = '',
    this.createdAt = '',
  });

  factory GradeRange.fromJson(Map<String, dynamic> json) {
    return GradeRange(
      id: json['id'] ?? '',
      cbseExamGradeId: json['cbse_exam_grade_id'] ?? '',
      name: json['name'] ?? '',
      minimumPercentage: json['minimum_percentage'] ?? '',
      maximumPercentage: json['maximum_percentage'] ?? '',
      description: json['description'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}


