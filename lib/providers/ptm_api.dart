import 'package:flutter/material.dart';
import 'package:masterjee/models/ptm/get_ptm_List_response.dart';
import 'package:masterjee/models/ptm/grouped_students_response.dart';
import 'package:masterjee/models/ptm/ptm_response.dart';
import 'package:masterjee/others/ApiHelper.dart';

class PtmApi with ChangeNotifier {

  Future<PtmResponse> savePtm(
      String userId,
      String ptmTitle,
      String date,
      String remark,
      List<Map<String, String>> slots) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'ptmTitle': ptmTitle,
      'date': date,
      'remark': remark,
      'slots': slots, // <-- List of maps here
    };

    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.savePtm, body);
    print("responseData : ${responseData}");
    return PtmResponse.fromJson(responseData);
  }

  Future<PtmListResponse> getPtmList(
      String userId,
    ) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getPtmList, body);
    print("responseData : ${responseData}");
    return PtmListResponse.fromJson(responseData);
  }

  Future<GroupedStudentsResponse> getGroupedStudents(
      String userId,
      String classId,
      String sectionId,
      ) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getGroupedStudents, body);
    print("GroupedStudentsResponse : ${responseData}");
    return GroupedStudentsResponse.fromJson(responseData);
  }

  Future<GroupedStudentsResponse> savePtmSchedule(
      String userId,
      String ptmId,
      String ptsId,
      List<Map<String, String>> students
      ) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'ptmId': ptmId,
      'ptsId': ptsId,
      'students': students,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.savePtmSchedule, body);
    print("GroupedStudentsResponse : ${responseData}");
    return GroupedStudentsResponse.fromJson(responseData);
  }

  Future<GroupedStudentsResponse> savePtmAttendance(
      String userId,
      String studentId,
      String feedbackScore,
      String feedbackRemark,
      String parentsComplain,
      String specialCase) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'studentId': studentId,
      'feedbackScore': feedbackScore,
      'feedbackRemark': feedbackRemark,
      'parentsComplain': parentsComplain,
      'specialCase': specialCase,
    };
    print("savePtmAttendance body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.savePtmAttendance, body);
    print("savePtmAttendance : ${responseData}");
    return GroupedStudentsResponse.fromJson(responseData);
  }

}
