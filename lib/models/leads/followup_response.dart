class FollowupResponse {
  final String status;
  final String message;
  final bool result;
  final List<FollowupData> data;

  FollowupResponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,
  });

  factory FollowupResponse.fromJson(Map<String, dynamic> json) {
    return FollowupResponse(
      status: json['status'],
      message: json['message'],
      result: json['result'],
      data: (json['data'] as List<dynamic>)
          .map((e) => FollowupData.fromJson(e))
          .toList(),
    );
  }
}

class FollowupData {
  final String fId;
  final String? cId;
  final String lId;
  final String followupDate;
  final String followupTime;
  final String nextFollowupDate;
  final String nextFollowupTime;
  final String followupRemark;
  final String callStatus;
  final String followupBy;
  final String followupStatus;
  final String followupPriority;
  final String isStudentRegistered;
  final String? registrationId;
  final String? referenceNo;
  final String isStudentAdmitted;
  final String? studentId;

  // Lead Info
  final String lName;
  final String? lGender;
  final String? lDob;
  final String lAadharNo;
  final String lBloodGroup;
  final String lFatherName;
  final String lFatherPhone;
  final String lFatherEmail;
  final String lFatherQualification;
  final String lMotherName;
  final String lMotherPhone;
  final String lMotherEmail;
  final String lMotherQualification;
  final String lGuardianName;
  final String lGuardianPhone;
  final String lGuardianEmail;
  final String lPhoneNumber;
  final String lAlternativePhone;
  final String lPrimaryEmailId;
  final String lEmergencyContactNo;
  final String lEmail;
  final String lNationality;
  final String lAddress;
  final String lReligion;
  final String lCaste;
  final String lSubCaste;
  final String lMotherTongue;
  final String lQualification;
  final String lClass;
  final String lEnrolledCourse;
  final String lElectiveSubjects;
  final String lTakenStatus;
  final String takenBy;
  final String currentAgent;
  final String lReverseStatus;
  final String? lTakenData;
  final String? lReverseData;
  final String lFollowUpData;
  final String lStatus;
  final String isClosed;
  final String closedDate;
  final String? closedBy;
  final String lManager;
  final String? lManagerData;
  final String lDate;
  final String lSource;
  final String lResources;
  final String individualStatus;
  final String lLocation;
  final String? leadLat;
  final String? leadLng;
  final String commissionGiven;
  final String level;
  final String? lTestScore;
  final String? lTestScoreRemark;

  // Campaign Info
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

  FollowupData({
    required this.fId,
    required this.cId,
    required this.lId,
    required this.followupDate,
    required this.followupTime,
    required this.nextFollowupDate,
    required this.nextFollowupTime,
    required this.followupRemark,
    required this.callStatus,
    required this.followupBy,
    required this.followupStatus,
    required this.followupPriority,
    required this.isStudentRegistered,
    required this.registrationId,
    required this.referenceNo,
    required this.isStudentAdmitted,
    required this.studentId,
    required this.lName,
    required this.lGender,
    required this.lDob,
    required this.lAadharNo,
    required this.lBloodGroup,
    required this.lFatherName,
    required this.lFatherPhone,
    required this.lFatherEmail,
    required this.lFatherQualification,
    required this.lMotherName,
    required this.lMotherPhone,
    required this.lMotherEmail,
    required this.lMotherQualification,
    required this.lGuardianName,
    required this.lGuardianPhone,
    required this.lGuardianEmail,
    required this.lPhoneNumber,
    required this.lAlternativePhone,
    required this.lPrimaryEmailId,
    required this.lEmergencyContactNo,
    required this.lEmail,
    required this.lNationality,
    required this.lAddress,
    required this.lReligion,
    required this.lCaste,
    required this.lSubCaste,
    required this.lMotherTongue,
    required this.lQualification,
    required this.lClass,
    required this.lEnrolledCourse,
    required this.lElectiveSubjects,
    required this.lTakenStatus,
    required this.takenBy,
    required this.currentAgent,
    required this.lReverseStatus,
    required this.lTakenData,
    required this.lReverseData,
    required this.lFollowUpData,
    required this.lStatus,
    required this.isClosed,
    required this.closedDate,
    required this.closedBy,
    required this.lManager,
    required this.lManagerData,
    required this.lDate,
    required this.lSource,
    required this.lResources,
    required this.individualStatus,
    required this.lLocation,
    required this.leadLat,
    required this.leadLng,
    required this.commissionGiven,
    required this.level,
    required this.lTestScore,
    required this.lTestScoreRemark,
    required this.ctId,
    required this.cpId,
    required this.cTitle,
    required this.cDescription,
    required this.cDate,
    required this.cBy,
    required this.cManager,
    required this.cManagerData,
    required this.cStatus,
    required this.otherInfo,
    required this.defaultShareMessage,
  });

  factory FollowupData.fromJson(Map<String, dynamic> json) {
    return FollowupData(
      fId: json['f_id'] ?? '',
      cId: json['c_id'],
      lId: json['l_id'] ?? '',
      followupDate: json['followup_date'] ?? '',
      followupTime: json['followup_time'] ?? '',
      nextFollowupDate: json['next_followup_date'] ?? '',
      nextFollowupTime: json['next_followup_time'] ?? '',
      followupRemark: json['followup_remark'] ?? '',
      callStatus: json['call_status'] ?? '',
      followupBy: json['followup_by'] ?? '',
      followupStatus: json['followup_status'] ?? '',
      followupPriority: json['followup_priority'] ?? '',
      isStudentRegistered: json['is_student_registered'] ?? '',
      registrationId: json['registration_id'],
      referenceNo: json['reference_no'],
      isStudentAdmitted: json['is_student_admitted'] ?? '',
      studentId: json['student_id'],
      lName: json['l_name'] ?? '',
      lGender: json['l_gender'],
      lDob: json['l_dob'],
      lAadharNo: json['l_aadhar_no'] ?? '',
      lBloodGroup: json['l_blood_group'] ?? '',
      lFatherName: json['l_father_name'] ?? '',
      lFatherPhone: json['l_father_phone'] ?? '',
      lFatherEmail: json['l_father_email'] ?? '',
      lFatherQualification: json['l_father_qualification'] ?? '',
      lMotherName: json['l_mother_name'] ?? '',
      lMotherPhone: json['l_mother_phone'] ?? '',
      lMotherEmail: json['l_mother_email'] ?? '',
      lMotherQualification: json['l_mother_qualification'] ?? '',
      lGuardianName: json['l_guradian_name'] ?? '',
      lGuardianPhone: json['l_guardian_phone'] ?? '',
      lGuardianEmail: json['l_guardian_email'] ?? '',
      lPhoneNumber: json['l_phone_number'] ?? '',
      lAlternativePhone: json['l_alternative_phone'] ?? '',
      lPrimaryEmailId: json['l_primary_email_id'] ?? '',
      lEmergencyContactNo: json['l_emergency_contact_no'] ?? '',
      lEmail: json['l_email'] ?? '',
      lNationality: json['l_nationality'] ?? '',
      lAddress: json['l_address'] ?? '',
      lReligion: json['l_religion'] ?? '',
      lCaste: json['l_caste'] ?? '',
      lSubCaste: json['l_sub_caste'] ?? '',
      lMotherTongue: json['l_mother_tongue'] ?? '',
      lQualification: json['l_qualification'] ?? '',
      lClass: json['l_class'] ?? '',
      lEnrolledCourse: json['l_enrolled_course'] ?? '',
      lElectiveSubjects: json['l_elective_subjects'] ?? '',
      lTakenStatus: json['l_taken_status'] ?? '',
      takenBy: json['taken_by'] ?? '',
      currentAgent: json['current_agent'] ?? '',
      lReverseStatus: json['l_reverse_status'] ?? '',
      lTakenData: json['l_taken_data'],
      lReverseData: json['l_reverse_data'],
      lFollowUpData: json['l_follow_up_data'] ?? '',
      lStatus: json['l_status'] ?? '',
      isClosed: json['is_closed'] ?? '',
      closedDate: json['closed_date'] ?? '',
      closedBy: json['closed_by'],
      lManager: json['l_manager'] ?? '',
      lManagerData: json['l_manager_data'],
      lDate: json['l_date'] ?? '',
      lSource: json['l_source'] ?? '',
      lResources: json['l_resources'] ?? '',
      individualStatus: json['individual_status'] ?? '',
      lLocation: json['l_location'] ?? '',
      leadLat: json['lead_lat']?.toString(),
      leadLng: json['lead_lng']?.toString(),
      commissionGiven: json['commission_given'] ?? '',
      level: json['level'] ?? '',
      lTestScore: json['l_test_score']?.toString(),
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
    );
  }

}
