import 'package:flutter/material.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/attendance_report/attendance_report_model.dart';
import 'package:masterjee/models/ptm/grouped_students_response.dart';
import 'package:masterjee/others/ApiHelper.dart';

class ClassAttendanceApi with ChangeNotifier {

  Future<AllStudentsResponse> getAllStudents(
      String userId, String classId, String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getAllStudents, body);
    print("responseData : ${responseData}");
    return AllStudentsResponse.fromJson(responseData);
  }

  Future<AttendanceReportResponse> getAttendanceReport(
      String userId, String classId, String sectionId, String date) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId,
      'date': date
    };
    print("body : ${body}");
    final responseData =
        await ApiHelper.post(ApiHelper.getAttendanceReport, body);
    print("responseData : ${responseData}");
    return AttendanceReportResponse.fromJson(responseData);
  }

  Future<AllStudentsResponse> saveStudentAttendance(
      String userId, String classId,List<Map<String, String>> students) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'date': classId,
      'attendance': students
    };
    print("body : ${body}");
    final responseData =
    await ApiHelper.post(ApiHelper.saveStudentAttendance, body);
    print("responseData : ${responseData}");
    return AllStudentsResponse.fromJson(responseData);
  }

}
