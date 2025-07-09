import 'AssessmentTypeModel.dart';

class AssessmentModel {
  final String id;
  final String name;
  final String description;
  final List<AssessmentTypeModel> types;

  AssessmentModel({
    this.id = "",
    this.name = "",
    this.description = "",
    this.types = const [],
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "types": types.map((e) => e.toJson()).toList(),
  };
}