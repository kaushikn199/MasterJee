import 'dart:io';

import 'package:flutter/material.dart';
import 'package:masterjee/models/course/course_model.dart';
import 'package:masterjee/models/course/course_report_model.dart';
import 'package:masterjee/models/course/single_course_model.dart';
import 'package:masterjee/models/error_model.dart';
import 'package:masterjee/models/exam/assesment/AllAssessmentsResponse.dart';
import 'package:masterjee/models/exam/GhradeResponse.dart';
import 'package:masterjee/models/exam/ObservationResponse.dart';
import 'package:masterjee/models/exam/assesment/assessment_info/AssessmentInfoResponse.dart';
import 'package:masterjee/models/exam/observation/ObservationInfoResponse.dart';
import 'package:masterjee/models/exam/schedule/ScheduleResponse.dart';
import 'package:masterjee/others/ApiHelper.dart';

class CourseApi with ChangeNotifier {
  Future<AllCourseData> allCourse(String userId, String classId, String sectionId) async {
    Map<String, dynamic> body = {'userId': userId, 'classId': classId, 'sectionId': sectionId};
    final responseData = await ApiHelper.post(ApiHelper.allCourse, body);
    print(body);
    print(responseData);
    return AllCourseData.fromJson(responseData);
  }

  Future<SingleCourseModule> getSingleMyCourses(
    String userId,
    String courseId,
  ) async {
    Map<String, dynamic> body = {'userId': userId, 'courseId': courseId};
    final responseData = await ApiHelper.post(ApiHelper.courseInfo, body);
    print(body);
    print(responseData);
    return SingleCourseModule.fromJson(responseData);
  }

  Future<GetCourseReportModel> getCourseReport(String userId, String classId, String sectionId) async {
    Map<String, dynamic> body = {'userId': userId, 'classId': classId, 'sectionId': sectionId};
    final responseData = await ApiHelper.post(ApiHelper.courseReports, body);
    print(body);
    print(responseData);
    return GetCourseReportModel.fromJson(responseData);
  }

  Future<CompleteReportResponse> getCompleteCourseReport(String userId, String classId, String sectionId) async {
    Map<String, dynamic> body = {'userId': userId, 'classId': classId, 'sectionId': sectionId};
    final responseData = await ApiHelper.post(ApiHelper.courseCompleteReports, body);
    return CompleteReportResponse.fromJson(responseData);
  }


  Future<SuccessData> saveCategory(String userId, String categoryName) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'categoryName': categoryName,
    };
    print(body);
    final responseData = await ApiHelper.post(ApiHelper.saveOnlineCourseCategory, body);
    print(responseData);
    return SuccessData.fromJson(responseData);
  }

  Future<ErrorMessageModel> saveLesson(Map<String, String> body, File? file, File? thumbFile) async {
    try {
      final responseData = await ApiHelper.postImagesDataWithBody(
          ApiHelper.saveOnlineCourseLesson, body, file, thumbFile,
          type: "lessonAttachment", type2: "lessonThumbnail");
      return ErrorMessageModel.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

  Future<ErrorMessageModel> saveCourse(Map<String, String> body, File? file) async {
    try {
      final responseData = await ApiHelper.postImagesDataWithBody(
          ApiHelper.saveOnlineCourse, body, file,null,
          type: "courseThumbnail",);
      return ErrorMessageModel.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

  Future<SuccessData> saveSections(String userId, String courseId, List<Map<String, String>> sections) async {
    Map<String, dynamic> body = {'userId': userId, "courseId": courseId, "sections": sections};
    print(body);
    print(body);

    final responseData = await ApiHelper.post(ApiHelper.saveCourseSections, body);
    print(body);
    print(responseData);
    return SuccessData.fromJson(responseData);
  }

  Future<SuccessData> saveOutComes(String userId, String courseId, List<Map<String, String>> outComes) async {
    Map<String, dynamic> body = {'userId': userId, "courseId": courseId, "outcomes": outComes};
    print(body);
    print(body);

    final responseData = await ApiHelper.post(ApiHelper.saveCourseOutcomes, body);
    print(body);
    print(responseData);
    return SuccessData.fromJson(responseData);
  }

  Future<AssessmentResponse> allAssessments(String userId, String classId, String sectionId) async {
    Map<String, dynamic> body = {'userId': userId, 'classId': classId, 'sectionId': sectionId};
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

  Future<AssessmentInfoResponse> assessmentInfo(String userId, String assessmentId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'assessmentId': assessmentId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.assessmentInfo, body);
    print("responseData : ${responseData}");
    return AssessmentInfoResponse.fromJson(responseData);
  }

  Future<ObservationResponse> saveParameter(String userId, String paramName) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'paramName': paramName,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveParameter, body);
    print("responseData : ${responseData}");
    return ObservationResponse.fromJson(responseData);
  }

  Future<ScheduleResponse> examSchedule(String userId) async {
    Map<String, dynamic> body = {'userId': userId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.examSchedule, body);
    print("responseData : ${responseData}");
    return ScheduleResponse.fromJson(responseData);
  }

  Future<ObservationInfoResponse> observationInfo(String userId, String observationId) async {
    Map<String, dynamic> body = {'userId': userId, 'observationId': observationId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.observationInfo, body);
    print("responseData : ${responseData}");
    return ObservationInfoResponse.fromJson(responseData);
  }
}
