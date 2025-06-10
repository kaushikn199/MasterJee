import 'package:flutter/material.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/all_student/student_template_model.dart';
import 'package:masterjee/models/attendance_report/attendance_report_model.dart';
import 'package:masterjee/models/error_model.dart';
import 'package:masterjee/models/student_progress/student_overall_model.dart';
import 'package:masterjee/models/users_info.dart';
import 'package:masterjee/others/ApiHelper.dart';
import 'package:masterjee/others/StorageHelper.dart';

class StudentProgressApi with ChangeNotifier {

  Future<AllStudentsTemplateResponse> getAllTemplate(String studentId) async {
    Map<String, dynamic> body = {'studentId': studentId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getStudentTemplates, body);
    print("responseData : ${responseData}");
    return AllStudentsTemplateResponse.fromJson(responseData);
  }

  Future<ErrorMessageModel> submitMarkSheet(
      Map<String, dynamic> body) async {
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentMarksheet, body);
    print("responseData : ${responseData}");
    return ErrorMessageModel.fromJson(responseData);
  }

  Future<OverallResponseData> getOverAllProgress(String studentId) async {
    Map<String, dynamic> body = {
      'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
      'studentId': studentId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentProgressTermWise, body);
    print("responseData : ${responseData}");
    return OverallResponseData.fromJson(responseData);
  }


  Future<List<AssessmentsData>> getProgressAssessmentWiseData(String studentId) async {
    Map<String, dynamic> body = {
      'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
      'studentId': studentId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentProgressAssessmentWise, body);
    print("responseData : ${responseData}");
    return parseAssessmentsData(responseData);
  }

  Future<List<SubjectData>> getProgressSubjectWise(String studentId) async {
    Map<String, dynamic> body = {
      'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
      'studentId': studentId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentProgressSubjectWise, body);
    print("responseData : ${responseData}");
    print("api :getProgressSubjectWise");

    return parseSubjectData(responseData);
  }

}


class SubjectData {
  final String subjectName;
  final double marks;
  final double maxMarks;

  SubjectData({required this.subjectName, required this.marks, required this.maxMarks});

  double get percentage => (marks / maxMarks) * 100;
}


List<SubjectData> parseSubjectData(Map<String, dynamic> json) {
  print("json");
  print(json);
  final List<dynamic> subjects = json['data']['subjects'] ?? [];
  return subjects.map((subject) {
    return SubjectData(
      subjectName: subject['subCode'] ?? '',
      marks: double.tryParse(subject['marks'] ?? '0') ?? 0,
      maxMarks: double.tryParse(subject['maximum_marks'] ?? '100') ?? 100,
    );
  }).toList();
}



class AssessmentsData {
  final String assessmentName;
  final double marks;
  final double maxMarks;

  AssessmentsData({required this.assessmentName, required this.marks, required this.maxMarks});

  double get percentage => (marks / maxMarks) * 100;
}


List<AssessmentsData> parseAssessmentsData(Map<String, dynamic> json) {
  print("json");
  print(json);
  final List<dynamic> assessments = json['data']['assessments'] ?? [];
  return assessments.map((subject) {
    return AssessmentsData(
      assessmentName: subject['name'] ?? '',
      marks: double.tryParse(subject['marks'] ?? '0') ?? 0,
      maxMarks: double.tryParse(subject['maximum_marks'] ?? '100') ?? 100,
    );
  }).toList();
}