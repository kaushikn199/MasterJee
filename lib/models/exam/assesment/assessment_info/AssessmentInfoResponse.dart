import 'package:masterjee/models/exam/assesment/AllAssessmentsResponse.dart';
import 'package:masterjee/models/exam/assesment/AssessmentModel.dart';

class AssessmentInfoResponse {
  final String status;
  final String message;
  final bool result;
  final AssessmentModel data;

  AssessmentInfoResponse({
    this.status = "",
    this.message = "",
    this.result = false,
    AssessmentModel? data,
  }) : data = data ?? AssessmentModel();

  factory AssessmentInfoResponse.fromJson(Map<String, dynamic> json) {
    return AssessmentInfoResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      result: json['result'] ?? false,
      data: AssessmentModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result,
    "data": data.toJson(),
  };
}