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
  final String lId;
  final String cId;
  final String isStudentRegistered;
  final String registrationId;
  final String referenceNo;
  final String isStudentAdmitted;
  final String studentId;
  final String lName;
  final String lGender;
  final String lDob;
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
  final String lTakenData;
  final String lReverseData;
  final String lFollowUpData;
  final String lStatus;
  final String isClosed;
  final String closedDate;
  final String closedBy;
  final String lManager;
  final String lManagerData;
  final String lDate;
  final String lSource;
  final String lResources;
  final String individualStatus;
  final String lLocation;
  final String leadLat;
  final String leadLng;
  final String commissionGiven;
  final String level;
  final String lTestScore;
  final String lTestScoreRemark;
  final String ctId;
  final String cpId;
  final String cTitle;
  final String cDescription;
  final String cDate;
  final String cBy;
  final String cManager;
  final String cManagerData;
  final String cStatus;
  final String otherInfo;
  final String defaultShareMessage;
  final List<FollowUpData> followUpData;
  final List<CampainUser> campainUser;

  LeadData({
    required this.lId,
    required this.cId,
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
    required this.followUpData,
    required this.campainUser,
  });

  factory LeadData.fromJson(Map<String, dynamic> json) {
    return LeadData(
      lId: json['l_id'] ?? '',
      cId: json['c_id'] ?? '',
      isStudentRegistered: json['is_student_registered'] ?? '',
      registrationId: json['registration_id'] ?? '',
      referenceNo: json['reference_no'] ?? '',
      isStudentAdmitted: json['is_student_admitted'] ?? '',
      studentId: json['student_id'] ?? '',
      lName: json['l_name'] ?? '',
      lGender: json['l_gender'] ?? '',
      lDob: json['l_dob'] ?? '',
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
      lTakenData: json['l_taken_data'] ?? '',
      lReverseData: json['l_reverse_data'] ?? '',
      lFollowUpData: json['l_follow_up_data'] ?? '',
      lStatus: json['l_status'] ?? '',
      isClosed: json['is_closed'] ?? '',
      closedDate: json['closed_date'] ?? '',
      closedBy: json['closed_by'] ?? '',
      lManager: json['l_manager'] ?? '',
      lManagerData: json['l_manager_data'] ?? '',
      lDate: json['l_date'] ?? '',
      lSource: json['l_source'] ?? '',
      lResources: json['l_resources'] ?? '',
      individualStatus: json['individual_status'] ?? '',
      lLocation: json['l_location'] ?? '',
      leadLat: json['lead_lat'] ?? '',
      leadLng: json['lead_lng'] ?? '',
      commissionGiven: json['commission_given'] ?? '',
      level: json['level'] ?? '',
      lTestScore: json['l_test_score'] ?? '',
      lTestScoreRemark: json['l_test_score_remark'] ?? '',
      ctId: json['ct_id'] ?? '',
      cpId: json['cp_id'] ?? '',
      cTitle: json['c_title'] ?? '',
      cDescription: json['c_description'] ?? '',
      cDate: json['c_date'] ?? '',
      cBy: json['c_by'] ?? '',
      cManager: json['c_manager'] ?? '',
      cManagerData: json['c_manager_data'] ?? '',
      cStatus: json['c_status'] ?? '',
      otherInfo: json['other_info'] ?? '',
      defaultShareMessage: json['default_share_message'] ?? '',
      followUpData: json['followUpData'] != null
          ? List<FollowUpData>.from(json['followUpData'].map((x) => FollowUpData.fromJson(x)))
          : [],
      campainUser: json['campainUser'] != null
          ? List<CampainUser>.from(json['campainUser'].map((x) => CampainUser.fromJson(x)))
          : [],
    );
  }
}



class FollowUpData {
  final String fId;
  final String cId;
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
  final String registrationId;
  final String referenceNo;
  final String isStudentAdmitted;
  final String studentId;

  FollowUpData({
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
  });

  factory FollowUpData.fromJson(Map<String, dynamic> json) {
    return FollowUpData(
      fId: json['f_id'] ?? '',
      cId: json['c_id'] ?? '',
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
      registrationId: json['registration_id'] ?? '',
      referenceNo: json['reference_no'] ?? '',
      isStudentAdmitted: json['is_student_admitted'] ?? '',
      studentId: json['student_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'f_id': fId,
      'c_id': cId,
      'l_id': lId,
      'followup_date': followupDate,
      'followup_time': followupTime,
      'next_followup_date': nextFollowupDate,
      'next_followup_time': nextFollowupTime,
      'followup_remark': followupRemark,
      'call_status': callStatus,
      'followup_by': followupBy,
      'followup_status': followupStatus,
      'followup_priority': followupPriority,
      'is_student_registered': isStudentRegistered,
      'registration_id': registrationId,
      'reference_no': referenceNo,
      'is_student_admitted': isStudentAdmitted,
      'student_id': studentId,
    };
  }
}

class CampainUser {
  final String lcId;
  final String cId;
  final String staffId;
  final String level;
  final String id;
  final String employeeId;
  final String langId;
  final String currencyId;
  final String? department;
  final String? designation;
  final String qualification;
  final String workExp;
  final String name;
  final String surname;
  final String fatherName;
  final String motherName;
  final String contactNo;
  final String emergencyContactNo;
  final String email;
  final String dob;
  final String maritalStatus;
  final String? dateOfJoining;
  final String dateOfLeaving;
  final String localAddress;
  final String permanentAddress;
  final String note;
  final String image;
  final String password;
  final String gender;
  final String accountTitle;
  final String bankAccountNo;
  final String bankName;
  final String ifscCode;
  final String bankBranch;
  final String payscale;
  final String basicSalary;
  final String epfNo;
  final String contractType;
  final String shift;
  final String location;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String instagram;
  final String resume;
  final String joiningLetter;
  final String resignationLetter;
  final String otherDocumentName;
  final String otherDocumentFile;
  final String userId;
  final String isActive;
  final String directManager;
  final String isHouseIncharge;
  final String verificationCode;
  final String? zoomApiKey;
  final String? zoomApiSecret;
  final String biometricDeviceId;
  final String? disableAt;
  final String deviceId;
  final String tokenId;
  final String? authToken;
  final String? expiredAt;
  final String? updatedAt;

  CampainUser({
    required this.lcId,
    required this.cId,
    required this.staffId,
    required this.level,
    required this.id,
    required this.employeeId,
    required this.langId,
    required this.currencyId,
    this.department,
    this.designation,
    required this.qualification,
    required this.workExp,
    required this.name,
    required this.surname,
    required this.fatherName,
    required this.motherName,
    required this.contactNo,
    required this.emergencyContactNo,
    required this.email,
    required this.dob,
    required this.maritalStatus,
    this.dateOfJoining,
    required this.dateOfLeaving,
    required this.localAddress,
    required this.permanentAddress,
    required this.note,
    required this.image,
    required this.password,
    required this.gender,
    required this.accountTitle,
    required this.bankAccountNo,
    required this.bankName,
    required this.ifscCode,
    required this.bankBranch,
    required this.payscale,
    required this.basicSalary,
    required this.epfNo,
    required this.contractType,
    required this.shift,
    required this.location,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.instagram,
    required this.resume,
    required this.joiningLetter,
    required this.resignationLetter,
    required this.otherDocumentName,
    required this.otherDocumentFile,
    required this.userId,
    required this.isActive,
    required this.directManager,
    required this.isHouseIncharge,
    required this.verificationCode,
    this.zoomApiKey,
    this.zoomApiSecret,
    required this.biometricDeviceId,
    this.disableAt,
    required this.deviceId,
    required this.tokenId,
    this.authToken,
    this.expiredAt,
    this.updatedAt,
  });

  factory CampainUser.fromJson(Map<String, dynamic> json) {
    return CampainUser(
      lcId: json['lc_id'] ?? '',
      cId: json['c_id'] ?? '',
      staffId: json['staff_id'] ?? '',
      level: json['level'] ?? '',
      id: json['id'] ?? '',
      employeeId: json['employee_id'] ?? '',
      langId: json['lang_id'] ?? '',
      currencyId: json['currency_id'] ?? '',
      department: json['department'],
      designation: json['designation'],
      qualification: json['qualification'] ?? '',
      workExp: json['work_exp'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      fatherName: json['father_name'] ?? '',
      motherName: json['mother_name'] ?? '',
      contactNo: json['contact_no'] ?? '',
      emergencyContactNo: json['emergency_contact_no'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] ?? '',
      maritalStatus: json['marital_status'] ?? '',
      dateOfJoining: json['date_of_joining'],
      dateOfLeaving: json['date_of_leaving'] ?? '',
      localAddress: json['local_address'] ?? '',
      permanentAddress: json['permanent_address'] ?? '',
      note: json['note'] ?? '',
      image: json['image'] ?? '',
      password: json['password'] ?? '',
      gender: json['gender'] ?? '',
      accountTitle: json['account_title'] ?? '',
      bankAccountNo: json['bank_account_no'] ?? '',
      bankName: json['bank_name'] ?? '',
      ifscCode: json['ifsc_code'] ?? '',
      bankBranch: json['bank_branch'] ?? '',
      payscale: json['payscale'] ?? '',
      basicSalary: json['basic_salary'] ?? '',
      epfNo: json['epf_no'] ?? '',
      contractType: json['contract_type'] ?? '',
      shift: json['shift'] ?? '',
      location: json['location'] ?? '',
      facebook: json['facebook'] ?? '',
      twitter: json['twitter'] ?? '',
      linkedin: json['linkedin'] ?? '',
      instagram: json['instagram'] ?? '',
      resume: json['resume'] ?? '',
      joiningLetter: json['joining_letter'] ?? '',
      resignationLetter: json['resignation_letter'] ?? '',
      otherDocumentName: json['other_document_name'] ?? '',
      otherDocumentFile: json['other_document_file'] ?? '',
      userId: json['user_id'] ?? '',
      isActive: json['is_active'] ?? '',
      directManager: json['direct_manager'] ?? '',
      isHouseIncharge: json['is_house_incharge'] ?? '',
      verificationCode: json['verification_code'] ?? '',
      zoomApiKey: json['zoom_api_key'],
      zoomApiSecret: json['zoom_api_secret'],
      biometricDeviceId: json['biometric_device_id'] ?? '',
      disableAt: json['disable_at'],
      deviceId: json['device_id'] ?? '',
      tokenId: json['token_id'] ?? '',
      authToken: json['auth_token'],
      expiredAt: json['expired_at'],
      updatedAt: json['updated_at'],
    );
  }
}
