
import 'package:flutter/material.dart';
import 'package:masterjee/models/leave_application_list_response/leave_application_list_response.dart';
import 'package:masterjee/models/subordinate_staff/subordinate_staff.dart';
import 'package:masterjee/models/user_leave_applications_info_response/leave_application_list_response.dart';
import 'package:masterjee/others/ApiHelper.dart';

class ApplyLeaveApi with ChangeNotifier {

  Future<LeaveApplicationListResponse> getLeaveApplicationForApproval(String userId,String classId,String sectionId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'classId': classId,
      'sectionId': sectionId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getLeaveApplicationForApproval, body);
    print("responseData : ${responseData}");
    return LeaveApplicationListResponse.fromJson(responseData);
  }

  Future<UserLeaveApplicationsInfoResponse> getUserLeaveApplicationsInfo(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getUserLeaveApplicationsInfo, body);
    print("responseData : ${responseData}");
    return UserLeaveApplicationsInfoResponse.fromJson(responseData);
  }

  Future<UserLeaveApplicationsInfoResponse> updateStaffLeaveStaus(String userId,String staffLeaveId,String staffLeaveAction) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'staffLeaveId': staffLeaveId,
      'staffLeaveAction': staffLeaveAction,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.updateStaffLeaveStaus, body);
    print("responseData : ${responseData}");
    return UserLeaveApplicationsInfoResponse.fromJson(responseData);
  }

  Future<UserLeaveApplicationsInfoResponse> updateStudentLeaveStaus(String userId,String leaveId,String leaveAction) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'leaveId': leaveId,
      'leaveAction': leaveAction,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.updateStudentLeaveStaus, body);
    print("responseData : ${responseData}");
    return UserLeaveApplicationsInfoResponse.fromJson(responseData);
  }


  Future<UserLeaveApplicationsInfoResponse> saveLeaveApplication(
      String userId,
      String staffId,
      String leaveTypeId,
      String fromDate,
      String toDate,
      String reason,
      String pendingLeave) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'staffId': staffId,
      'leaveTypeId': leaveTypeId,
      'fromDate': fromDate,
      'toDate': toDate,
      'reason': reason,
      'pendingLeave': pendingLeave,
    };

    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveLeaveApplication, body);
    print("responseData : ${responseData}");
    return UserLeaveApplicationsInfoResponse.fromJson(responseData);
  }


  Future<SubordinateStaffResponse> getSubordinateStaff(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getSubordinateStaff, body);
    print("responseData : ${responseData}");
    return SubordinateStaffResponse.fromJson(responseData);
  }

}
