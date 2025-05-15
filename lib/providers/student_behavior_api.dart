import 'package:flutter/material.dart';
import 'package:masterjee/models/student_behavior/student_behavior_response.dart';
import 'package:masterjee/models/student_behaviour_incident/student_behaviour_incident.dart';
import 'package:masterjee/models/student_behaviour_rank/student_behaviour_rank_response.dart';
import 'package:masterjee/others/ApiHelper.dart';

class StudentBehaviorApi with ChangeNotifier {

  Future<StudentBehaviorResponse> studentBehaviour(String userId,
      String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentBehaviour, body);
    print("responseData : ${responseData}");
    return StudentBehaviorResponse.fromJson(responseData);
  }

  Future<StudentBehaviourRankResponse> studentBehaviourRank(String userId,
      String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentBehaviourRank, body);
    print("responseData : ${responseData}");
    return StudentBehaviourRankResponse.fromJson(responseData);
  }


  Future<StudentBehaviorIncidentResponse> studentBehaviourIncident(String userId,
      String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.studentBehaviourIncident, body);
    print("responseData : ${responseData}");
    return StudentBehaviorIncidentResponse.fromJson(responseData);
  }

}