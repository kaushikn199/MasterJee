class GradeResponse {
  final String status;
  final String message;
  final bool result;
  final List<GradeModel> data;

  GradeResponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,
  });

  factory GradeResponse.fromJson(Map<String, dynamic> json) {
    return GradeResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GradeModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class GradeModel {
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final List<GradeRangeModel> ranges;

  GradeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.ranges,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      ranges: (json['ranges'] as List<dynamic>?)
          ?.map((e) => GradeRangeModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class GradeRangeModel {
  final String id;
  final String cbseExamGradeId;
  final String name;
  final String minimumPercentage;
  final String maximumPercentage;
  final String description;
  final String createdBy;
  final String createdAt;

  GradeRangeModel({
    required this.id,
    required this.cbseExamGradeId,
    required this.name,
    required this.minimumPercentage,
    required this.maximumPercentage,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  factory GradeRangeModel.fromJson(Map<String, dynamic> json) {
    return GradeRangeModel(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cbse_exam_grade_id': cbseExamGradeId,
      'name': name,
      'minimum_percentage': minimumPercentage,
      'maximum_percentage': maximumPercentage,
      'description': description,
      'created_by': createdBy,
      'created_at': createdAt,
    };
  }
}