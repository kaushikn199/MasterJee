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
  String cbseObservationParameterId;
  final String maximumMarks;
  final String description;
  final String? createdBy;
  final String createdAt;
  final String name;
  final String pvid;
  final String pvcopid;
  final String pname;
  String? selectedParam;
  String? selectedParamId;

  ObservationParamModel({
     this.id = "",
     this.cbseExamObservationId = "",
     this.cbseObservationParameterId = "",
     this.maximumMarks = "",
     this.description = "",
     this.createdBy = "",
     this.createdAt = "",
     this.name = "",
     this.pvid = "",
     this.pvcopid = "",
     this.pname = "",
     this.selectedParam = null,
     this.selectedParamId = null,
  });

  factory ObservationParamModel.fromJson(Map<String, dynamic> json) {
    String pname = json['pname'] ?? '';
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
      pname: pname,
      selectedParam: pname.isNotEmpty ? pname : null,
      selectedParamId: null,
    );
  }

/*  factory ObservationParamModel.fromJson(Map<String, dynamic> json) {
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
      selectedParam: json['selectedParam'] ?? null,
    );
  }*/
}