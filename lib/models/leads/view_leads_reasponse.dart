class ViewLeadsResponse {
  final String status;
  final String message;
  final bool result;
  final LeadData? data;

  ViewLeadsResponse({
    required this.status,
    required this.message,
    required this.result,
    this.data,
  });

  factory ViewLeadsResponse.fromJson(Map<String, dynamic> json) {
    return ViewLeadsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: json['data'] != null ? LeadData.fromJson(json['data']) : null,
    );
  }
}

class LeadData {
  final String? lId;
  final String? cId;
  final String? isStudentRegistered;
  final String? registrationId;
  final String? referenceNo;
  final String? isStudentAdmitted;
  final String? studentId;
  final String? lName;
  final String? lGender;
  final String? lDob;
  final String? lAadharNo;
  final String? lBloodGroup;
  final String? lFatherName;
  final String? lFatherPhone;
  final String? lFatherEmail;
  final String? lFatherQualification;
  final String? lMotherName;
  final String? lMotherPhone;
  final String? lMotherEmail;
  final String? lMotherQualification;
  final String? lGuradianName;
  final String? lGuardianPhone;
  final String? lGuardianEmail;
  final String? lPhoneNumber;
  final String? lAlternativePhone;
  final String? lPrimaryEmailId;
  final String? lEmergencyContactNo;
  final String? lEmail;
  final String? lNationality;
  final String? lAddress;
  final String? lReligion;
  final String? lCaste;
  final String? lSubCaste;
  final String? lMotherTongue;
  final String? lQualification;
  final String? lClass;
  final String? lEnrolledCourse;
  final String? lElectiveSubjects;
  final String? lTakenStatus;
  final String? takenBy;
  final String? currentAgent;
  final String? lReverseStatus;
  final String? lTakenData;
  final String? lReverseData;
  final String? lFollowUpData;
  final String? lStatus;
  final String? isClosed;
  final String? closedDate;
  final String? closedBy;
  final String? lManager;
  final String? lManagerData;
  final String? lDate;
  final String? lSource;
  final String? lResources;
  final String? individualStatus;
  final String? lLocation;
  final String? leadLat;
  final String? leadLng;
  final String? commissionGiven;
  final String? level;
  final String? lTestScore;
  final String? lTestScoreRemark;
  final String? ctId;
  final String? cpId;
  final String? cTitle;
  final String? cDescription;
  final String? cDate;
  final String? cBy;
  final String? cManager;
  final String? cManagerData;
  final String? cStatus;
  final String? otherInfo;
  final String? defaultShareMessage;
  final List<FollowUpData>? followUpData;

  LeadData({
    this.lId,
    this.cId,
    this.isStudentRegistered,
    this.registrationId,
    this.referenceNo,
    this.isStudentAdmitted,
    this.studentId,
    this.lName,
    this.lGender,
    this.lDob,
    this.lAadharNo,
    this.lBloodGroup,
    this.lFatherName,
    this.lFatherPhone,
    this.lFatherEmail,
    this.lFatherQualification,
    this.lMotherName,
    this.lMotherPhone,
    this.lMotherEmail,
    this.lMotherQualification,
    this.lGuradianName,
    this.lGuardianPhone,
    this.lGuardianEmail,
    this.lPhoneNumber,
    this.lAlternativePhone,
    this.lPrimaryEmailId,
    this.lEmergencyContactNo,
    this.lEmail,
    this.lNationality,
    this.lAddress,
    this.lReligion,
    this.lCaste,
    this.lSubCaste,
    this.lMotherTongue,
    this.lQualification,
    this.lClass,
    this.lEnrolledCourse,
    this.lElectiveSubjects,
    this.lTakenStatus,
    this.takenBy,
    this.currentAgent,
    this.lReverseStatus,
    this.lTakenData,
    this.lReverseData,
    this.lFollowUpData,
    this.lStatus,
    this.isClosed,
    this.closedDate,
    this.closedBy,
    this.lManager,
    this.lManagerData,
    this.lDate,
    this.lSource,
    this.lResources,
    this.individualStatus,
    this.lLocation,
    this.leadLat,
    this.leadLng,
    this.commissionGiven,
    this.level,
    this.lTestScore,
    this.lTestScoreRemark,
    this.ctId,
    this.cpId,
    this.cTitle,
    this.cDescription,
    this.cDate,
    this.cBy,
    this.cManager,
    this.cManagerData,
    this.cStatus,
    this.otherInfo,
    this.defaultShareMessage,
    this.followUpData,
  });

  factory LeadData.fromJson(Map<String, dynamic> json) {
    return LeadData(
      lId: json['l_id'],
      cId: json['c_id'],
      isStudentRegistered: json['is_student_registered'],
      registrationId: json['registration_id'],
      referenceNo: json['reference_no'],
      isStudentAdmitted: json['is_student_admitted'],
      studentId: json['student_id'],
      lName: json['l_name'],
      lGender: json['l_gender'],
      lDob: json['l_dob'],
      lAadharNo: json['l_aadhar_no'],
      lBloodGroup: json['l_blood_group'],
      lFatherName: json['l_father_name'],
      lFatherPhone: json['l_father_phone'],
      lFatherEmail: json['l_father_email'],
      lFatherQualification: json['l_father_qualification'],
      lMotherName: json['l_mother_name'],
      lMotherPhone: json['l_mother_phone'],
      lMotherEmail: json['l_mother_email'],
      lMotherQualification: json['l_mother_qualification'],
      lGuradianName: json['l_guradian_name'],
      lGuardianPhone: json['l_guardian_phone'],
      lGuardianEmail: json['l_guardian_email'],
      lPhoneNumber: json['l_phone_number'],
      lAlternativePhone: json['l_alternative_phone'],
      lPrimaryEmailId: json['l_primary_email_id'],
      lEmergencyContactNo: json['l_emergency_contact_no'],
      lEmail: json['l_email'],
      lNationality: json['l_nationality'],
      lAddress: json['l_address'],
      lReligion: json['l_religion'],
      lCaste: json['l_caste'],
      lSubCaste: json['l_sub_caste'],
      lMotherTongue: json['l_mother_tongue'],
      lQualification: json['l_qualification'],
      lClass: json['l_class'],
      lEnrolledCourse: json['l_enrolled_course'],
      lElectiveSubjects: json['l_elective_subjects'],
      lTakenStatus: json['l_taken_status'],
      takenBy: json['taken_by'],
      currentAgent: json['current_agent'],
      lReverseStatus: json['l_reverse_status'],
      lTakenData: json['l_taken_data'],
      lReverseData: json['l_reverse_data'],
      lFollowUpData: json['l_follow_up_data'],
      lStatus: json['l_status'],
      isClosed: json['is_closed'],
      closedDate: json['closed_date'],
      closedBy: json['closed_by'],
      lManager: json['l_manager'],
      lManagerData: json['l_manager_data'],
      lDate: json['l_date'],
      lSource: json['l_source'],
      lResources: json['l_resources'],
      individualStatus: json['individual_status'],
      lLocation: json['l_location'],
      leadLat: json['lead_lat'],
      leadLng: json['lead_lng'],
      commissionGiven: json['commission_given'],
      level: json['level'],
      lTestScore: json['l_test_score'],
      lTestScoreRemark: json['l_test_score_remark'],
      ctId: json['ct_id'],
      cpId: json['cp_id'],
      cTitle: json['c_title'],
      cDescription: json['c_description'],
      cDate: json['c_date'],
      cBy: json['c_by'],
      cManager: json['c_manager'],
      cManagerData: json['c_manager_data'],
      cStatus: json['c_status'],
      otherInfo: json['other_info'],
      defaultShareMessage: json['default_share_message'],
      followUpData: json['followUpData'] != null
          ? List<FollowUpData>.from(
          json['followUpData'].map((x) => FollowUpData.fromJson(x)))
          : null,
    );
  }
}

class FollowUpData {
  final String? fId;
  final String? cId;
  final String? lId;
  final String? followupDate;
  final String? followupTime;
  final String? nextFollowupDate;
  final String? nextFollowupTime;
  final String? followupRemark;
  final String? callStatus;
  final String? followupBy;
  final String? followupStatus;
  final String? followupPriority;
  final String? isStudentRegistered;
  final String? registrationId;
  final String? referenceNo;
  final String? isStudentAdmitted;
  final String? studentId;

  // You can include other repeating fields if necessary (e.g., l_name, l_email, etc.)

  FollowUpData({
    this.fId,
    this.cId,
    this.lId,
    this.followupDate,
    this.followupTime,
    this.nextFollowupDate,
    this.nextFollowupTime,
    this.followupRemark,
    this.callStatus,
    this.followupBy,
    this.followupStatus,
    this.followupPriority,
    this.isStudentRegistered,
    this.registrationId,
    this.referenceNo,
    this.isStudentAdmitted,
    this.studentId,
  });

  factory FollowUpData.fromJson(Map<String, dynamic> json) {
    return FollowUpData(
      fId: json['f_id'],
      cId: json['c_id'],
      lId: json['l_id'],
      followupDate: json['followup_date'],
      followupTime: json['followup_time'],
      nextFollowupDate: json['next_followup_date'],
      nextFollowupTime: json['next_followup_time'],
      followupRemark: json['followup_remark'],
      callStatus: json['call_status'],
      followupBy: json['followup_by'],
      followupStatus: json['followup_status'],
      followupPriority: json['followup_priority'],
      isStudentRegistered: json['is_student_registered'],
      registrationId: json['registration_id'],
      referenceNo: json['reference_no'],
      isStudentAdmitted: json['is_student_admitted'],
      studentId: json['student_id'],
    );
  }
}
