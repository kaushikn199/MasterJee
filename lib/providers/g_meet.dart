
import 'package:flutter/cupertino.dart';
import 'package:masterjee/models/gmeet_response/GMeetResponse.dart';
import 'package:masterjee/others/ApiHelper.dart';

class GMeetApi with ChangeNotifier {

  Future<GMeetResponse> getAllGMeet(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getAllGMeetClassesReports, body);
    print("responseData : ${responseData}");
    return GMeetResponse.fromJson(responseData);
  }

}
