
import 'package:flutter/material.dart';
import 'package:masterjee/models/dues_report_response/DuesReportResponse.dart';
import 'package:masterjee/models/pay_slip/pay_slip_info.dart';
import 'package:masterjee/models/pay_slip/pay_slip_response.dart';
import 'package:masterjee/others/ApiHelper.dart';

class PaySlipApi with ChangeNotifier {

  Future<PaySlipResponse> getAllPayslip(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getAllPayslip, body);
    print("responseData : ${responseData}");
    return PaySlipResponse.fromJson(responseData);
  }

  Future<PaySlipInfoResponse> getPayslipInfo(String userId,String payslipId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'payslipId': payslipId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getPayslipInfo, body);
    print("responseData : ${responseData}");
    return PaySlipInfoResponse.fromJson(responseData);
  }

}