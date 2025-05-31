class CampaignLeadsResponse {
  final String status;
  final String message;
  final List<LeadData> data;
  final bool result;

  CampaignLeadsResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory CampaignLeadsResponse.fromJson(Map<String, dynamic> json) {
    return CampaignLeadsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)?.map((e) => LeadData.fromJson(e)).
      toList() ?? [],
      result: json['result'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
    'result': result,
  };
}

class LeadData {
  final CampaignLead leads;
  final List<dynamic> followUps;

  LeadData({
    required this.leads,
    required this.followUps,
  });

  factory LeadData.fromJson(Map<String, dynamic> json) {
    return LeadData(
      leads: CampaignLead.fromJson(json['leads'] ?? {}),
      followUps: json['followUps'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'leads': leads.toJson(),
    'followUps': followUps,
  };
}

class CampaignLead {
  final String lId;
  final String cId;
  final String isStudentRegistered;
  final String? registrationId;
  final String? referenceNo;
  final String isStudentAdmitted;
  final String? studentId;
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
  final String lGuradianName;
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
  final String? lFollowUpData;
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
  final String leadLat;
  final String leadLng;
  final String commissionGiven;
  final String level;
  final String? lTestScore;
  final String? lTestScoreRemark;
  final String? ctId;
  final String? cpId;
  final String cTitle;
  final String cDescription;
  final String cDate;
  final String cBy;
  final String cManager;
  final String? cManagerData;
  final String cStatus;
  final String? otherInfo;
  final String? defaultShareMessage;

  CampaignLead({
    required this.lId,
    required this.cId,
    required this.isStudentRegistered,
    this.registrationId,
    this.referenceNo,
    required this.isStudentAdmitted,
    this.studentId,
    required this.lName,
    this.lGender,
    this.lDob,
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
    required this.lGuradianName,
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
    this.lTakenData,
    this.lReverseData,
    this.lFollowUpData,
    required this.lStatus,
    required this.isClosed,
    required this.closedDate,
    this.closedBy,
    required this.lManager,
    this.lManagerData,
    required this.lDate,
    required this.lSource,
    required this.lResources,
    required this.individualStatus,
    required this.lLocation,
    required this.leadLat,
    required this.leadLng,
    required this.commissionGiven,
    required this.level,
    this.lTestScore,
    this.lTestScoreRemark,
    this.ctId,
    this.cpId,
    required this.cTitle,
    required this.cDescription,
    required this.cDate,
    required this.cBy,
    required this.cManager,
    this.cManagerData,
    required this.cStatus,
    this.otherInfo,
    this.defaultShareMessage,
  });

  factory CampaignLead.fromJson(Map<String, dynamic> json) {
    return CampaignLead(
      lId: json['l_id'] ?? '',
      cId: json['c_id'] ?? '',
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
      lGuradianName: json['l_guradian_name'] ?? '',
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
      lFollowUpData: json['l_follow_up_data'],
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
      leadLat: json['lead_lat'] ?? '',
      leadLng: json['lead_lng'] ?? '',
      commissionGiven: json['commission_given'] ?? '',
      level: json['level'] ?? '',
      lTestScore: json['l_test_score'],
      lTestScoreRemark: json['l_test_score_remark'],
      ctId: json['ct_id'],
      cpId: json['cp_id'],
      cTitle: json['c_title'] ?? '',
      cDescription: json['c_description'] ?? '',
      cDate: json['c_date'] ?? '',
      cBy: json['c_by'] ?? '',
      cManager: json['c_manager'] ?? '',
      cManagerData: json['c_manager_data'],
      cStatus: json['c_status'] ?? '',
      otherInfo: json['other_info'],
      defaultShareMessage: json['default_share_message'],
    );
  }

  Map<String, dynamic> toJson() => {
    'l_id': lId,
    'c_id': cId,
    'is_student_registered': isStudentRegistered,
    'registration_id': registrationId,
    'reference_no': referenceNo,
    'is_student_admitted': isStudentAdmitted,
    'student_id': studentId,
    'l_name': lName,
    'l_gender': lGender,
    'l_dob': lDob,
    'l_aadhar_no': lAadharNo,
    'l_blood_group': lBloodGroup,
    'l_father_name': lFatherName,
    'l_father_phone': lFatherPhone,
    'l_father_email': lFatherEmail,
    'l_father_qualification': lFatherQualification,
    'l_mother_name': lMotherName,
    'l_mother_phone': lMotherPhone,
    'l_mother_email': lMotherEmail,
    'l_mother_qualification': lMotherQualification,
    'l_guradian_name': lGuradianName,
    'l_guardian_phone': lGuardianPhone,
    'l_guardian_email': lGuardianEmail,
    'l_phone_number': lPhoneNumber,
    'l_alternative_phone': lAlternativePhone,
    'l_primary_email_id': lPrimaryEmailId,
    'l_emergency_contact_no': lEmergencyContactNo,
    'l_email': lEmail,
    'l_nationality': lNationality,
    'l_address': lAddress,
    'l_religion': lReligion,
    'l_caste': lCaste,
    'l_sub_caste': lSubCaste,
    'l_mother_tongue': lMotherTongue,
    'l_qualification': lQualification,
    'l_class': lClass,
    'l_enrolled_course': lEnrolledCourse,
    'l_elective_subjects': lElectiveSubjects,
    'l_taken_status': lTakenStatus,
    'taken_by': takenBy,
    'current_agent': currentAgent,
    'l_reverse_status': lReverseStatus,
    'l_taken_data': lTakenData,
    'l_reverse_data': lReverseData,
    'l_follow_up_data': lFollowUpData,
    'l_status': lStatus,
    'is_closed': isClosed,
    'closed_date': closedDate,
    'closed_by': closedBy,
    'l_manager': lManager,
    'l_manager_data': lManagerData,
    'l_date': lDate,
    'l_source': lSource,
    'l_resources': lResources,
    'individual_status': individualStatus,
    'l_location': lLocation,
    'lead_lat': leadLat,
    'lead_lng': leadLng,
    'commission_given': commissionGiven,
    'level': level,
    'l_test_score': lTestScore,
    'l_test_score_remark': lTestScoreRemark,
    'ct_id': ctId,
    'cp_id': cpId,
    'c_title': cTitle,
    'c_description': cDescription,
    'c_date': cDate,
    'c_by': cBy,
    'c_manager': cManager,
    'c_manager_data': cManagerData,
    'c_status': cStatus,
    'other_info': otherInfo,
    'default_share_message': defaultShareMessage,
  };
}

class FollowUpData {
  final String cId;
  final String lId;
  final String followupDate;
  final String followupTime;
  final String nextFollowupDate;
  final String nextFollowupTime;
  final String followupRemark;
  final String callStatus;
  final String followupBy;

  FollowUpData({
    required this.cId,
    required this.lId,
    required this.followupDate,
    required this.followupTime,
    required this.nextFollowupDate,
    required this.nextFollowupTime,
    required this.followupRemark,
    required this.callStatus,
    required this.followupBy,
  });

  factory FollowUpData.fromJson(Map<String, dynamic> json) {
    return FollowUpData(
      cId: json['c_id'] ?? '',
      lId: json['l_id'] ?? '',
      followupDate: json['followup_date'] ?? '',
      followupTime: json['followup_time'] ?? '',
      nextFollowupDate: json['next_followup_date'] ?? '',
      nextFollowupTime: json['next_followup_time'] ?? '',
      followupRemark: json['followup_remark'] ?? '',
      callStatus: json['call_status'] ?? '',
      followupBy: json['followup_by'] ?? '',
    );
  }
}