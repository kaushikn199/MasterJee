import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:masterjee/models/common_functions.dart';

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
        throw Exception(responseData['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      print('API ERROR: $e');
      rethrow;
    }
  }




}
