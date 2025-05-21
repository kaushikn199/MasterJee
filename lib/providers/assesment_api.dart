


import 'package:flutter/material.dart';
import 'package:masterjee/models/assesment_response/assesment_reponse.dart';
import 'package:masterjee/others/ApiHelper.dart';

class AssesmentApi with ChangeNotifier {

  Future<AssesmentResponse> studentAssessment(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentAssessment, body);
    print("responseData : ${responseData}");
    return AssesmentResponse.fromJson(responseData);
  }

  Future<AssesmentResponse> saveStudentAssessment(
     String userId,
     String batchId,
     String subjectId,
     List<Map<String, dynamic>> assessments)
  async {

    Map<String, dynamic> body = {
      'userId': userId,
      'batchId': batchId,
      'subjectId': subjectId,
      'assessments': assessments,
    };
    print("Request Body: $body");
    final responseData = await ApiHelper.post(ApiHelper.saveStudentAssessment, body);
    print("Response Data: $responseData");
    return AssesmentResponse.fromJson(responseData);
  }

}