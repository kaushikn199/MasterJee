import 'package:masterjee/models/exam/assesment/AssessmentModel.dart';
import 'package:masterjee/models/exam/assesment/AssessmentTypeModel.dart';

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

