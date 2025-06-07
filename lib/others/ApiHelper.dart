import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/widgets/app_tags.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class ApiHelper {

  static const login = 'login';
  static const getClassSection = 'getClassSection';
  static const getDuesReport = 'getDuesReport';
  static const getAllGMeetClassesReports = 'allGmeetClassesReports';
  static const getClassTimetable = 'getClassTimetable';
  static const getLeaveApplicationForApproval = 'getLeaveApplicationForApproval';
  static const getUserLeaveApplicationsInfo = 'getUserLeaveApplicationsInfo';
  static const updateStaffLeaveStaus = 'updateStaffLeaveStaus';
  static const updateStudentLeaveStaus = 'updateStudentLeaveStaus';
  static const saveLeaveApplication = 'saveLeaveApplication';
  static const getSubordinateStaff = 'getSubordinateStaff';
  static const getAllStudents = 'getAllStudents';
  static const getAttendanceReport = 'getAttendanceReport';
  static const saveStudentAttendance = 'saveStudentAttendance';
  static const getHomeworkList = 'getHomeworkList';
  static const getSubmittedHomeworkInfo = 'getSubmittedHomeworkInfo';
  static const saveHomeworkScore = 'saveHomeworkScore';
  static const getTeachersSubject = 'getTeachersSubject';
  static const studentBehaviour = 'studentBehaviour';
  static const studentBehaviourRank = 'studentBehaviourRank';
  static const studentBehaviourIncident = 'studentBehaviourIncident';
  static const studentBehaviourView = 'studentBehaviourView';
  static const saveIncidentComment = 'saveIncidentComment';
  static const studentAssessment = 'studentAssessment';
  static const saveStudentAssessment = 'saveStudentAssessment';
  static const leads = 'leads';
  static const allFollowup = 'allFollowup';
  static const missedLeads = 'missedLeads';
  static const walkinLeads = 'walkinLeads';
  static const savePtm = 'savePtm';
  static const campaignLeads = 'campaignLeads';
  static const leadsView = 'leadsView';
  static const saveFollowUp = 'saveFollowUp';
  static const saveLeadTransfer = 'saveLeadTransfer';
  static const getPtmList = 'getPtmList';
  static const getGroupedStudents = 'getGroupedStudents';
  static const savePtmSchedule = 'savePtmSchedule';
  static const savePtmAttendance = 'savePtmAttendance';
  static const saveLead = 'saveLead';


  static const Map<String, String> defaultHeaders = {
    'Client-Service': "smartschool",
    'Auth-Key': "schoolAdmin@",
    'Content-Type': 'application/json',
  };

  static Future<Map<String, dynamic>> post(
      String endpoint,
      Map<String, dynamic> body, {
        Map<String, String>? customHeaders,
      }) async {
    var url = Uri.parse('$BASE_URL$endpoint');
    print("url : $url");

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      CommonFunctions.showSuccessToast("No internet connection");
      throw Exception('No Internet Connection'); // Stop further code execution
    }

    try {
      final response = await http.post(
        url,
        headers: customHeaders ?? defaultHeaders,
        body: jsonEncode(body),
      );

      print('API POST [$endpoint] => ${response.statusCode}');
      print('Response: ${response.body}');

      final responseData = json.decode(response.body);
      print('responseData: $responseData');

      if (response.statusCode == 200) {
        return responseData;
      } else {
        CommonFunctions.showWarningToast((responseData['message'] ?? 'Something went wrong'));
        throw Exception(responseData['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      print('API ERROR: $e');
      rethrow;
    }
  }




}
