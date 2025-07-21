import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:path/path.dart';
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
  static const getStudentTemplates = 'cbseReportCardTemplate';
  static const getAttendanceReport = 'getAttendanceReport';
  static const saveStudentAttendance = 'saveStudentAttendance';
  static const studentMarksheet = 'studentMarksheet';
  static const studentProgressAssessmentWise = 'studentProgressAssessmentWise';
  static const studentProgressTermWise = 'studentProgressTermWise';
  static const studentProgressSubjectWise = 'studentProgressSubjectWise';
  static const getHomeworkList = 'getHomeworkList';
  static const getContent = 'getContent';
  static const getHostels = 'hostels';
  static const saveHostel = 'saveHostel';
  static const sendNotice = 'sendNotice';
  static const saveCommunication = 'sendMessage';
  static const saveHostelRoom = 'saveHostelRoom';
  static const getHostelRooms = 'hostelRooms';
  static const getCommunicationLogs = 'getCommunicationLogs';
  static const getNotices = 'getNotices';
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
  static const String qrAttendance = "qr_mark_attendance";
  static const String faceAuthentication = "face_authentication";
  static const String markAttendance = "mark_attendance";
  static const String usersInfo = "users_info";
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
  static const saveHomework = 'saveHomework';
  static const addLessonPlan = 'addLessonPlan';
  static const saveLessonPlan = 'saveLessonPlan';
  static const getAllPayslip = 'getAllPayslip';
  static const getPayslipInfo = 'getPayslipInfo';
  static const getTimetableStudents = 'getTimetableStudents';
  static const saveStudentPeriodAttendance = 'saveStudentPeriodAttendance';
  static const getAssignmentList = 'getAssignmentList';
  static const allExams = 'allExams';
  static const allAssessments = 'allAssessments';
  static const allGrades = 'allGrades';
  static const allObservation = 'allObservation';
  static const assessmentInfo = 'assessmentInfo';
  static const saveParameter = 'saveParameter';
  static const assignObservation = 'assignObservation';
  static const examSchedule = 'examSchedule';
  static const observationInfo = 'observationInfo';
  static const saveAssessment = 'saveAssessment';
  static const saveObservation = 'saveObservation';
  static const saveTerm = 'saveTerm';
  static const generateRank = 'generateRank';
  static const getExamStudents = 'getExamStudents';
  static const examSubjects = 'examSubjects';
  static const assignStudents  = 'assignStudents';
  static const examScore = 'examScore';
  static const saveExamScore = 'saveExamScore';
  static const allTerms = 'allTerms';
  static const gradesInfo = 'gradesInfo';
  static const saveGrade = 'saveGrade';
  static const getExamAssignedStudents = 'getExamAssignedStudents';
  static const addExamAttendance = 'addExamAttendance';
  static const allExamAssessments = 'allExamAssessments';
  static const saveExamSubjects = 'saveExamSubjects';

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
        //throw Exception(responseData['message'] ?? 'Something went wrong');
        return responseData;
      }
    } catch (e) {
      print('API ERROR: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> postImageDataWithBody(String endpoint, Map<String, String> body, File? file,
      {Map<String, String>? customHeaders, String type = 'image'}) async {
    var url = Uri.parse('$BASE_URL$endpoint');
    var requestBody = http.MultipartRequest('POST', url);
    requestBody.headers['Client-Service'] = "smartschool";
    requestBody.headers['Auth-Key'] = "schoolAdmin@";
    requestBody.headers['Content-Type'] = "application/json";

    requestBody.fields.addAll(body);
    if (file != null) {
      var stream = http.ByteStream(file.openRead())..cast();
      var length = await file.length();
      var multipartFile = http.MultipartFile(type, stream, length, filename: basename(file.path));
      requestBody.files.add(multipartFile);
    } else {
      requestBody.fields[type] = "";
    }
    print("requestBody");
    print(requestBody.files);
    print(requestBody.fields);
    print(requestBody.url);
    print(requestBody.method);
    try {
      int attempts = 0;
      while (attempts < 3) {
        attempts++;
        final r = await requestBody.send().timeout(Duration(seconds: file == null ? 10 : 30));
        final result = await http.Response.fromStream(r);
        final responseData = json.decode(result.body);
        print(responseData);
        if (result.statusCode == 200) {
          return responseData;
        } else {
          CommonFunctions.showWarningToast((responseData['message'] ?? 'Something went wrong'));
          //throw Exception(responseData['message'] ?? 'Something went wrong');
          return responseData;
        }
      }
    } catch (e) {
      print('API ERROR: $e');
      rethrow;
    }
    return {};
  }
}
