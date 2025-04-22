import 'package:flutter/material.dart';
import 'package:masterjee/models/class_timetable/class_time_table_response.dart';
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

}