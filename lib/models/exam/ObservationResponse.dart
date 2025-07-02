class ObservationResponse {
  final String status;
  final String message;
  final bool result;
  final List<ObservationModel> data;

  ObservationResponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,
  });

  factory ObservationResponse.fromJson(Map<String, dynamic> json) {
    return ObservationResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ObservationModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class ObservationModel {
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final List<ObservationParamModel> params;

  ObservationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.params,
  });

  factory ObservationModel.fromJson(Map<String, dynamic> json) {
    return ObservationModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      params: (json['params'] as List<dynamic>?)
          ?.map((e) => ObservationParamModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class ObservationParamModel {
  final String id;
  final String cbseExamObservationId;
  final String cbseObservationParameterId;
  final String maximumMarks;
  final String description;
  final String? createdBy;
  final String createdAt;
  final String name;
  final String pvid;
  final String pvcopid;
  final String pname;

  ObservationParamModel({
    required this.id,
    required this.cbseExamObservationId,
    required this.cbseObservationParameterId,
    required this.maximumMarks,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.name,
    required this.pvid,
    required this.pvcopid,
    required this.pname,
  });

  factory ObservationParamModel.fromJson(Map<String, dynamic> json) {
    return ObservationParamModel(
      id: json['id'] ?? '',
      cbseExamObservationId: json['cbse_exam_observation_id'] ?? '',
      cbseObservationParameterId: json['cbse_observation_parameter_id'] ?? '',
      maximumMarks: json['maximum_marks'] ?? '',
      description: json['description'] ?? '',
      createdBy: json['created_by'],
      createdAt: json['created_at'] ?? '',
      name: json['name'] ?? '',
      pvid: json['pvid'] ?? '',
      pvcopid: json['pvcopid'] ?? '',
      pname: json['pname'] ?? '',
    );
  }
}