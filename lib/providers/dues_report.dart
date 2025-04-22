
import 'package:flutter/cupertino.dart';
import 'package:masterjee/models/class_section/class_section_response.dart';
import 'package:masterjee/models/dues_report_response/DuesReportResponse.dart';
import 'package:masterjee/others/ApiHelper.dart';

class DuesReport with ChangeNotifier {

  Future<DuesReportResponse> getDuesReport(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getDuesReport, body);
    print("responseData : ${responseData}");
    return DuesReportResponse.fromJson(responseData);
  }

}