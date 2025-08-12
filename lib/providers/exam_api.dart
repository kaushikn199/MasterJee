
import 'package:flutter/material.dart';
import 'package:masterjee/models/exam/assesment/AllAssessmentsResponse.dart';
import 'package:masterjee/models/exam/ExamResponse.dart';
import 'package:masterjee/models/exam/GhradeResponse.dart';
import 'package:masterjee/models/exam/ObservationResponse.dart';
import 'package:masterjee/models/exam/assesment/assessment_info/AssessmentInfoResponse.dart';
import 'package:masterjee/models/exam/exam/AllExamAssessmentsResponse.dart';
import 'package:masterjee/models/exam/exam/ExamAssignedStudentsResponse.dart';
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

  Future<ExamSubjectResponse> saveExam(
      String userId,
      String classId,
      String sectionId,
      String term,
      String assessment,
      String grade,
      String examName,
      String description,
      String publish,
      )
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId,
      'term': term,
      'assessment': assessment,
      'grade': grade,
      'examName': examName,
      'description': description,
      'publish': publish,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveExam, body);
    print("responseData : ${responseData}");
    return ExamSubjectResponse.fromJson(responseData);
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

  Future<ExamScoreResponse> assignStudents (String userId,String eId,List<Map<String, dynamic>> stuIds)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examId': eId,
      'stuIds': stuIds
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.assignStudents, body);
    print("responseData : ${responseData}");
    return ExamScoreResponse.fromJson(responseData);
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


  Future<ExamScoreResponse> saveExamScore(
      String userId,
      String examTimetableId,
      List<Map<String, dynamic>> studentsData)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examTimetableId': examTimetableId,
      'studentsData': studentsData
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveExamScore, body);
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

  Future<GradesInfoResponse> saveGrade(
      String userId,
      String gradeId,
      String gradeName,
      String gradeDescription,
      List<Map<String, dynamic>> rangesData)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'gradeId': gradeId,
      'gradeName': gradeName,
      'gradeDescription': gradeDescription,
      'rangesData': rangesData,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveGrade, body);
    print("responseData : ${responseData}");
    return GradesInfoResponse.fromJson(responseData);
  }


  Future<ExamAssignedStudentsResponse> getExamAssignedStudents(
      String userId,
      String examId)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examId': examId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getExamAssignedStudents, body);
    print("responseData : ${responseData}");
    return ExamAssignedStudentsResponse.fromJson(responseData);
  }

  Future<ExamAssignedStudentsResponse> addExamAttendance(
      String userId,
      String examId,
      String etdays,
      List<Map<String, dynamic>> attendances
      )
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examId': examId,
      'etdays': etdays,
      'attendances': attendances,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.addExamAttendance, body);
    print("responseData : ${responseData}");
    return ExamAssignedStudentsResponse.fromJson(responseData);
  }

  Future<AllExamAssessmentsResponse> allExamAssessments(String userId,String examId)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examId': examId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.allExamAssessments, body);
    print("responseData : ${responseData}");
    return AllExamAssessmentsResponse.fromJson(responseData);
  }

  Future<AllExamAssessmentsResponse> saveExamSubjects(
      String userId,
      String examId,
      String subjectId,
      String examDate,
      String examTime,
      String duration,
      String roomNumber,
      List<Map<String, dynamic>> assessData
      )
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'examId': examId,
      'subjectId': subjectId,
      'examDate': examDate,
      'examTime': examTime,
      'duration': duration,
      'roomNumber': roomNumber,
      'assessData': assessData,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveExamSubjects, body);
    print("responseData : ${responseData}");
    return AllExamAssessmentsResponse.fromJson(responseData);
  }

}