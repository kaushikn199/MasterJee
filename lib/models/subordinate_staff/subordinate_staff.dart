class SubordinateStaffResponse {
  String? status;
  String? message;
  List<SubordinateStaffData>? data;
  bool? result;

  SubordinateStaffResponse({this.status, this.message, this.data, this.result});

  factory SubordinateStaffResponse.fromJson(Map<String, dynamic> json) {
    return SubordinateStaffResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SubordinateStaffData.fromJson(e))
          .toList(),
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'result': result,
    };
  }
}

class SubordinateStaffData {
  String? id;
  String? employeeId;
  String? langId;
  String? currencyId;
  String? department;
  String? designation;
  String? qualification;
  String? workExp;
  String? name;
  String? surname;
  String? fatherName;
  String? motherName;
  String? contactNo;
  String? emergencyContactNo;
  String? email;
  String? dob;
  String? maritalStatus;
  String? dateOfJoining;
  String? dateOfLeaving;
  String? localAddress;
  String? permanentAddress;
  String? note;
  String? image;
  String? password;
  String? gender;
  String? accountTitle;
  String? bankAccountNo;
  String? bankName;
  String? ifscCode;
  String? bankBranch;
  String? payscale;
  String? basicSalary;
  String? epfNo;
  String? contractType;
  String? shift;
  String? location;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? instagram;
  String? resume;
  String? joiningLetter;
  String? resignationLetter;
  String? otherDocumentName;
  String? otherDocumentFile;
  String? userId;
  String? isActive;
  String? directManager;
  String? isHouseIncharge;
  String? verificationCode;
  String? zoomApiKey;
  String? zoomApiSecret;
  String? biometricDeviceId;
  String? disableAt;
  String? deviceId;
  String? tokenId;
  String? authToken;
  String? expiredAt;
  String? updatedAt;
  String? empid;

  SubordinateStaffData({
    this.id,
    this.employeeId,
    this.langId,
    this.currencyId,
    this.department,
    this.designation,
    this.qualification,
    this.workExp,
    this.name,
    this.surname,
    this.fatherName,
    this.motherName,
    this.contactNo,
    this.emergencyContactNo,
    this.email,
    this.dob,
    this.maritalStatus,
    this.dateOfJoining,
    this.dateOfLeaving,
    this.localAddress,
    this.permanentAddress,
    this.note,
    this.image,
    this.password,
    this.gender,
    this.accountTitle,
    this.bankAccountNo,
    this.bankName,
    this.ifscCode,
    this.bankBranch,
    this.payscale,
    this.basicSalary,
    this.epfNo,
    this.contractType,
    this.shift,
    this.location,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
    this.resume,
    this.joiningLetter,
    this.resignationLetter,
    this.otherDocumentName,
    this.otherDocumentFile,
    this.userId,
    this.isActive,
    this.directManager,
    this.isHouseIncharge,
    this.verificationCode,
    this.zoomApiKey,
    this.zoomApiSecret,
    this.biometricDeviceId,
    this.disableAt,
    this.deviceId,
    this.tokenId,
    this.authToken,
    this.expiredAt,
    this.updatedAt,
    this.empid,
  });

  factory SubordinateStaffData.fromJson(Map<String, dynamic> json) {
    return SubordinateStaffData(
      id: json['id']?.toString(),
      employeeId: json['employee_id'],
      langId: json['lang_id'],
      currencyId: json['currency_id'],
      department: json['department'],
      designation: json['designation'],
      qualification: json['qualification'],
      workExp: json['work_exp'],
      name: json['name'],
      surname: json['surname'],
      fatherName: json['father_name'],
      motherName: json['mother_name'],
      contactNo: json['contact_no'],
      emergencyContactNo: json['emergency_contact_no'],
      email: json['email'],
      dob: json['dob'],
      maritalStatus: json['marital_status'],
      dateOfJoining: json['date_of_joining'],
      dateOfLeaving: json['date_of_leaving'],
      localAddress: json['local_address'],
      permanentAddress: json['permanent_address'],
      note: json['note'],
      image: json['image'],
      password: json['password'],
      gender: json['gender'],
      accountTitle: json['account_title'],
      bankAccountNo: json['bank_account_no'],
      bankName: json['bank_name'],
      ifscCode: json['ifsc_code'],
      bankBranch: json['bank_branch'],
      payscale: json['payscale'],
      basicSalary: json['basic_salary'],
      epfNo: json['epf_no'],
      contractType: json['contract_type'],
      shift: json['shift'],
      location: json['location'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      linkedin: json['linkedin'],
      instagram: json['instagram'],
      resume: json['resume'],
      joiningLetter: json['joining_letter'],
      resignationLetter: json['resignation_letter'],
      otherDocumentName: json['other_document_name'],
      otherDocumentFile: json['other_document_file'],
      userId: json['user_id'],
      isActive: json['is_active']?.toString(),
      directManager: json['direct_manager'],
      isHouseIncharge: json['is_house_incharge'],
      verificationCode: json['verification_code'],
      zoomApiKey: json['zoom_api_key'],
      zoomApiSecret: json['zoom_api_secret'],
      biometricDeviceId: json['biometric_device_id'],
      disableAt: json['disable_at'],
      deviceId: json['device_id'],
      tokenId: json['token_id'],
      authToken: json['auth_token'],
      expiredAt: json['expired_at'],
      updatedAt: json['updated_at'],
      empid: json['empid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'lang_id': langId,
      'currency_id': currencyId,
      'department': department,
      'designation': designation,
      'qualification': qualification,
      'work_exp': workExp,
      'name': name,
      'surname': surname,
      'father_name': fatherName,
      'mother_name': motherName,
      'contact_no': contactNo,
      'emergency_contact_no': emergencyContactNo,
      'email': email,
      'dob': dob,
      'marital_status': maritalStatus,
      'date_of_joining': dateOfJoining,
      'date_of_leaving': dateOfLeaving,
      'local_address': localAddress,
      'permanent_address': permanentAddress,
      'note': note,
      'image': image,
      'password': password,
      'gender': gender,
      'account_title': accountTitle,
      'bank_account_no': bankAccountNo,
      'bank_name': bankName,
      'ifsc_code': ifscCode,
      'bank_branch': bankBranch,
      'payscale': payscale,
      'basic_salary': basicSalary,
      'epf_no': epfNo,
      'contract_type': contractType,
      'shift': shift,
      'location': location,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'resume': resume,
      'joining_letter': joiningLetter,
      'resignation_letter': resignationLetter,
      'other_document_name': otherDocumentName,
      'other_document_file': otherDocumentFile,
      'user_id': userId,
      'is_active': isActive,
      'direct_manager': directManager,
      'is_house_incharge': isHouseIncharge,
      'verification_code': verificationCode,
      'zoom_api_key': zoomApiKey,
      'zoom_api_secret': zoomApiSecret,
      'biometric_device_id': biometricDeviceId,
      'disable_at': disableAt,
      'device_id': deviceId,
      'token_id': tokenId,
      'auth_token': authToken,
      'expired_at': expiredAt,
      'updated_at': updatedAt,
      'empid': empid,
    };
  }
}
