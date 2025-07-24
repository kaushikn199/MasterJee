
import 'package:flutter/foundation.dart';
import 'package:masterjee/models/reports/HostelReportsResponse.dart';
import 'package:masterjee/others/ApiHelper.dart';

class ReportsApi with ChangeNotifier {

  Future<Hostelreportsresponse> hostelReports(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.hostelReports, body);
    print("responseData : ${responseData}");
    return Hostelreportsresponse.fromJson(responseData);
  }

  Future<Hostelreportsresponse> transportReports(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.transportReports, body);
    print("responseData : ${responseData}");
    return Hostelreportsresponse.fromJson(responseData);
  }

  Future<Hostelreportsresponse> assignmentReports(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.assignmentReports, body);
    print("responseData : ${responseData}");
    return Hostelreportsresponse.fromJson(responseData);
  }

  Future<Hostelreportsresponse> studentsReports(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentsReports, body);
    print("responseData : ${responseData}");
    return Hostelreportsresponse.fromJson(responseData);
  }


  Future<Hostelreportsresponse> parentLoginReports(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.parentLoginReports, body);
    print("responseData : ${responseData}");
    return Hostelreportsresponse.fromJson(responseData);
  }


  Future<Hostelreportsresponse> siblingReports(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.siblingReports, body);
    print("responseData : ${responseData}");
    return Hostelreportsresponse.fromJson(responseData);
  }

}