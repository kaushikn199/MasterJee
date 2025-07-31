import 'package:flutter/material.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/all_student/student_template_model.dart';
import 'package:masterjee/models/attendance_report/attendance_report_model.dart';
import 'package:masterjee/models/error_model.dart';
import 'package:masterjee/models/users_info.dart';
import 'package:masterjee/others/ApiHelper.dart';

class ClassAttendanceApi with ChangeNotifier {

  Future<AllStudentsResponse> getAllStudents(String userId, String classId, String sectionId) async {
    Map<String, dynamic> body = {'userId': userId, 'classId': classId, 'sectionId': sectionId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getAllStudents, body);
    print("responseData : ${responseData}");
    return AllStudentsResponse.fromJson(responseData);
  }

  Future<AllStudentsResponse> saveStudentBehaviour(String userId, String studentId, List<Map<String, String>> behaviours) async {
    Map<String, dynamic> body = {'userId': userId, 'studentId': studentId, 'behaviours': behaviours};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveStudentBehaviour, body);
    print("responseData : ${responseData}");
    return AllStudentsResponse.fromJson(responseData);
  }

  Future<AttendanceReportResponse> getAttendanceReport(
      String userId, String classId, String sectionId, String date) async {
    Map<String, dynamic> body = {'userId': userId, 'classId': classId, 'sectionId': sectionId, 'date': date};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getAttendanceReport, body);
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
    final responseData = await ApiHelper.post(ApiHelper.saveStudentAttendance, body);
    print("responseData : ${responseData}");
    return AllStudentsResponse.fromJson(responseData);
  }

  //qr attendance api
  static Future<ErrorMessageModel> qrAttendance(var body) async {
    final responseData = await ApiHelper.post(ApiHelper.qrAttendance, body);
    print("responseData : ${responseData}");
    return ErrorMessageModel.fromJson(responseData);
  }

  //face attendance register api
  static Future<ErrorMessageModel> registerFace(var body) async {
    final responseData = await ApiHelper.post(ApiHelper.faceAuthentication, body);
    print("responseData : ${responseData}");
    return ErrorMessageModel.fromJson(responseData);
  }

  //mark face attendance api
  static Future<ErrorMessageModel> markFaceAttendance(var body) async {
    final responseData = await ApiHelper.post(ApiHelper.markAttendance, body);
    print("responseData : ${responseData}");
    return ErrorMessageModel.fromJson(responseData);
  }

  //get users mark face attendance api
  static Future<UsersListModel> getUsers(var body) async {
    final responseData = await ApiHelper.post(ApiHelper.usersInfo, body);
    print("responseData : ${responseData}");
    return UsersListModel.fromJson(responseData);
  }
}
