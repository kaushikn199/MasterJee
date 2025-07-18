
import 'package:flutter/material.dart';
import 'package:masterjee/models/exam/assesment/AllAssessmentsResponse.dart';
import 'package:masterjee/models/exam/ExamResponse.dart';
import 'package:masterjee/models/exam/GhradeResponse.dart';
import 'package:masterjee/models/exam/ObservationResponse.dart';
import 'package:masterjee/models/exam/assesment/assessment_info/AssessmentInfoResponse.dart';
import 'package:masterjee/models/exam/exam/ExamScoreResponse.dart';
import 'package:masterjee/models/exam/exam/ExamStudentsResponse.dart';
import 'package:masterjee/models/exam/exam/ExamSubjectsResponse.dart';
import 'package:masterjee/models/exam/grades/GradesInfoResponse.dart';
import 'package:masterjee/models/exam/observation/AllTermsResponse.dart';
import 'package:masterjee/models/exam/observation/ObservationInfoResponse.dart';
import 'package:masterjee/models/exam/schedule/ScheduleResponse.dart';
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

  Future<ExamResponse> generateRank(String userId,String examId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examId': examId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.generateRank, body);
    print("responseData : ${responseData}");
    return ExamResponse.fromJson(responseData);
  }

  Future<ExamStudentsResponse> getExamStudents(String userId,String examId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examId': examId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getExamStudents, body);
    print("responseData : ${responseData}");
    return ExamStudentsResponse.fromJson(responseData);
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


  Future<TermListResponse> allTerms(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.allTerms, body);
    print("responseData : ${responseData}");
    return TermListResponse.fromJson(responseData);
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

  Future<ObservationResponse> saveParameter(String userId,String paramName) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'paramName': paramName,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveParameter, body);
    print("responseData : ${responseData}");
    return ObservationResponse.fromJson(responseData);
  }

  Future<ObservationResponse> assignObservation(
      String userId,
      String obsrvId,
      String termId,
      String description) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'obsrvId': obsrvId,
      'termId': termId,
      'description': description,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.assignObservation, body);
    print("responseData : ${responseData}");
    return ObservationResponse.fromJson(responseData);
  }

  Future<ScheduleResponse> examSchedule(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.examSchedule, body);
    print("responseData : ${responseData}");
    return ScheduleResponse.fromJson(responseData);
  }

  Future<ObservationInfoResponse> observationInfo(String userId,String observationId)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'observationId': observationId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.observationInfo, body);
    print("responseData : ${responseData}");
    return ObservationInfoResponse.fromJson(responseData);
  }

  Future<AssessmentInfoResponse> saveAssessment(String userId,
      String assessmentId,
      String assessmentName,
      String assessmentDescription,
      List<Map<String, String>> assessTypeData)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'assessmentId': assessmentId,
      'assessmentName': assessmentName,
      'assessmentDescription': assessmentDescription,
      'assessTypeData': assessTypeData,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveAssessment, body);
    print("responseData : ${responseData}");
    return AssessmentInfoResponse.fromJson(responseData);
  }

  Future<ObservationInfoResponse> saveObservation(
      String userId,
      String obsrvId,
      String obsrvName,
      String obsrvDescription,
      List<Map<String, String>> parametersData)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'obsrvId': obsrvId,
      'obsrvName': obsrvName,
      'obsrvDescription': obsrvDescription,
      'parametersData': parametersData,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveObservation, body);
    print("responseData : ${responseData}");
    return ObservationInfoResponse.fromJson(responseData);
  }

  Future<ObservationInfoResponse> saveTerm(
      String userId,
      String termName,
      String termCode,
      String termDescription,
      ) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'termName': termName,
      'termCode': termCode,
      'termDescription': termDescription,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveTerm, body);
    print("responseData : ${responseData}");
    return ObservationInfoResponse.fromJson(responseData);
  }

  Future<ExamSubjectResponse> examSubjects(String userId,String examId)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examId': examId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.examSubjects, body);
    print("responseData : ${responseData}");
    return ExamSubjectResponse.fromJson(responseData);
  }

  Future<ExamScoreResponse> examScore(String userId,String eId,String sId)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'eId': eId,
      'sId': sId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.examScore, body);
    print("responseData : ${responseData}");
    return ExamScoreResponse.fromJson(responseData);
  }

  Future<GradesInfoResponse> gradesInfo(String userId,String gradeId)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'gradeId': gradeId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.gradesInfo, body);
    print("responseData : ${responseData}");
    return GradesInfoResponse.fromJson(responseData);
  }

}