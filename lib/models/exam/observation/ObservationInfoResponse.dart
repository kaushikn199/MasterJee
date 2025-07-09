class ObservationInfoResponse {
  final String status;
  final String message;
  final bool result;
  final ObservationData data;

  ObservationInfoResponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,
  });

  factory ObservationInfoResponse.fromJson(Map<String, dynamic> json) {
    return ObservationInfoResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: ObservationData.fromJson(json['data'] ?? {}),
    );
  }
}


class ObservationData {
  final Observation observation;
  final List<Parameter> parameters;

  ObservationData({
    required this.observation,
    required this.parameters,
  });

  factory ObservationData.fromJson(Map<String, dynamic> json) {
    return ObservationData(
      observation: Observation.fromJson(json['observation'] ?? {}),
      parameters: (json['parameters'] as List<dynamic>? ?? [])
          .map((e) => Parameter.fromJson(e))
          .toList(),
    );
  }
}


class Observation {
  final String id;
  final String name;
  final String description;
  final String createdAt;

  Observation({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory Observation.fromJson(Map<String, dynamic> json) {
    return Observation(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class Parameter {
  final String id;
  final String name;
  final String description;
  final String createdAt;

  Parameter({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}