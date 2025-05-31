import 'package:flutter/material.dart';
import 'package:masterjee/models/ptm/ptm_response.dart';
import 'package:masterjee/others/ApiHelper.dart';

class PtmApi with ChangeNotifier {

  Future<PtmResponse> savePtm(
      String userId,
      String ptmTitle,
      String date,
      String remark,
      String fromTime,
      String toTime) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'ptmTitle': ptmTitle,
      'date': date,
      'remark': remark,
      'fromTime': fromTime,
      'toTime': toTime,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.savePtm, body);
    print("responseData : ${responseData}");
    return PtmResponse.fromJson(responseData);
  }

}
