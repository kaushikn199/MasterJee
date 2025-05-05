
import 'package:flutter/material.dart';
import 'package:masterjee/models/homework_list/HomeworkListResponse.dart';
import 'package:masterjee/models/submitted_homework_info/submitted_homework_info.dart';
import 'package:masterjee/others/ApiHelper.dart';

class HomeworkApi with ChangeNotifier {

  Future<HomeworkListResponse> getHomeworkList(String userId,String classId,
      String sectionId,String type) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId,
      'type': type
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getHomeworkList, body);
    print("responseData : ${responseData}");
    return HomeworkListResponse.fromJson(responseData);
  }

  Future<SubmittedHomeworkResponse> getSubmittedHomeworkInfo(String userId,
      String homeworkId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'homeworkId': homeworkId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getSubmittedHomeworkInfo, body);
    print("responseData : ${responseData}");
    return SubmittedHomeworkResponse.fromJson(responseData);
  }


  Future<SubmittedHomeworkResponse> saveHomeworkScore(String userId,
      String homeworkId,String studentId,String score,String note) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'homeworkId': homeworkId,
      'studentId': studentId,
      'score': score,
      'note': note,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveHomeworkScore, body);
    print("responseData : ${responseData}");
    return SubmittedHomeworkResponse.fromJson(responseData);
  }

}