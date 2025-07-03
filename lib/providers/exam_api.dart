
import 'package:flutter/material.dart';
import 'package:masterjee/models/exam/assesment/AllAssessmentsResponse.dart';
import 'package:masterjee/models/exam/ExamResponse.dart';
import 'package:masterjee/models/exam/GhradeResponse.dart';
import 'package:masterjee/models/exam/ObservationResponse.dart';
import 'package:masterjee/models/exam/assesment/assessment_info/AssessmentInfoResponse.dart';
import 'package:masterjee/models/gmeet_response/GMeetResponse.dart';
import 'package:masterjee/others/ApiHelper.dart';

class ExamApi with ChangeNotifier {

  Future<ExamResponse> allExams(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.allExams, body);
    print("responseData : ${responseData}");
    return ExamResponse.fromJson(responseData);
  }


  Future<AssessmentResponse> allAssessments(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.allAssessments, body);
    print("responseData : ${responseData}");
    return AssessmentResponse.fromJson(responseData);
  }

  Future<GradeResponse> allGrades(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.allGrades, body);
    print("responseData : ${responseData}");
    return GradeResponse.fromJson(responseData);
  }



  Future<ObservationResponse> allObservation(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.allObservation, body);
    print("responseData : ${responseData}");
    return ObservationResponse.fromJson(responseData);
  }

  Future<AssessmentInfoResponse> assessmentInfo(String userId,String assessmentId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'assessmentId': assessmentId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.assessmentInfo, body);
    print("responseData : ${responseData}");
    return AssessmentInfoResponse.fromJson(responseData);
  }

}