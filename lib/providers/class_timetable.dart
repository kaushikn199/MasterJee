import 'package:flutter/material.dart';
import 'package:masterjee/models/class_timetable/add_lesson_plan_response.dart';
import 'package:masterjee/models/class_timetable/class_time_table_response.dart';
import 'package:masterjee/models/timetable_students/TimetableStudentsResponse.dart';
import 'package:masterjee/others/ApiHelper.dart';

class ClassTimetable with ChangeNotifier {

  Future<ClassTimetableResponse> getClassTimetable(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getClassTimetable, body);
    print("responseData : ${responseData}");
    return ClassTimetableResponse.fromJson(responseData);
  }

  Future<AddLessonPlanResponse> addLessonPlan(String userId,String sgsid,String ttid) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'sgsid': sgsid,
      'ttid': ttid
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.addLessonPlan, body);
    print("addLessonPlan : ${responseData}");
    return AddLessonPlanResponse.fromJson(responseData);
  }

  Future<AddLessonPlanResponse> saveLessonPlan(
      String userId,
      String lessonId,
      String topicId,
      String subTopic,
      String date,
      String timeFrom,
      String timeTo,
      String lactureYoutubeUrl,
      String teachingMethod,
      String generalObjectives,
      String previousKnowledge,
      String comprehensiveQuestions)
  async {
    Map<String, dynamic> body = {
      'userId': userId,
      'lessonId': lessonId,
      'topicid': topicId,
      'subTopic': subTopic,
      'date': date,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'lactureYoutubeUrl': lactureYoutubeUrl,
      'teachingMethod': teachingMethod,
      'generalObjectives': generalObjectives,
      'previousKnowledge': previousKnowledge,
      'comprehensiveQuestions': comprehensiveQuestions,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveLessonPlan, body);
    print("saveLessonPlan Api : ${responseData}");
    return AddLessonPlanResponse.fromJson(responseData);
  }

  Future<TimetableStudentsResponse> getTimetableStudents(String userId,String timetableId,String subjectGroupId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'timetableId': timetableId,
      'subjectGroupId': subjectGroupId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getTimetableStudents, body);
    print("responseData : ${responseData}");
    return TimetableStudentsResponse.fromJson(responseData);
  }

  Future<TimetableStudentsResponse> saveStudentPeriodAttendance(
      String userId, String timetableId,String date,List<Map<String, String>> attendance) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'timetableId': timetableId,
      'date': date,
      'attendance': attendance
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveStudentPeriodAttendance, body);
    print("responseData : ${responseData}");
    return TimetableStudentsResponse.fromJson(responseData);
  }

}