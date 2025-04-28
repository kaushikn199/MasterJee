class LeaveApplicationListResponse {
  LeaveApplicationListResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  final String status;
  final String message;
  final Data? data;
  final bool result;

  factory LeaveApplicationListResponse.fromJson(Map<String, dynamic> json){
    return LeaveApplicationListResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      result: json["result"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "result": result,
  };

}

class Data {
  Data({
    required this.stuLeave,
    required this.stfLeave,
  });

  final List<StuLeave> stuLeave;
  final List<StfLeave> stfLeave;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      //stuLeave: json["stuLeave"] == null ? [] : List<StuLeave>.from(json["stuLeave"]?.map((x) => StuLeave.fromJson(x))),
      stuLeave: json["stuLeave"] is List
          ? List<StuLeave>.from(
          (json["stuLeave"] as List)
              .where((x) => x is Map<String, dynamic>)
              .map((x) => StuLeave.fromJson(x as Map<String, dynamic>)))
          : [],
      stfLeave: json["stfLeave"] == null ? [] : List<StfLeave>.from(json["stfLeave"]?.map((x) => StfLeave.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "stuLeave": stuLeave.map((x) => x.toJson()).toList(),
    "stfLeave": stfLeave.map((x) => x.toJson()).toList(),
  };

}

class StfLeave {
  StfLeave({
    required this.id,
    required this.employeeId,
    required this.langId,
    required this.currencyId,
    required this.department,
    required this.designation,
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
    required this.dateOfJoining,
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
    required this.zoomApiKey,
    required this.zoomApiSecret,
    required this.biometricDeviceId,
    required this.disableAt,
    required this.deviceId,
    required this.tokenId,
    required this.authToken,
    required this.expiredAt,
    required this.updatedAt,
    required this.empid,
    required this.staffLeave,
  });

  final dynamic id;
  final String employeeId;
  final String langId;
  final String currencyId;
  final dynamic department;
  final dynamic designation;
  final String qualification;
  final String workExp;
  final String name;
  final String surname;
  final String fatherName;
  final String motherName;
  final String contactNo;
  final String emergencyContactNo;
  final String email;
  final DateTime? dob;
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
  final dynamic isActive;
  final String directManager;
  final String isHouseIncharge;
  final String verificationCode;
  final dynamic zoomApiKey;
  final dynamic zoomApiSecret;
  final String biometricDeviceId;
  final dynamic disableAt;
  final String deviceId;
  final String tokenId;
  final dynamic authToken;
  final dynamic expiredAt;
  final dynamic updatedAt;
  final String empid;
  final List<StaffLeave> staffLeave;

  factory StfLeave.fromJson(Map<String, dynamic> json){
    return StfLeave(
      id: json["id"],
      employeeId: json["employee_id"] ?? "",
      langId: json["lang_id"] ?? "",
      currencyId: json["currency_id"] ?? "",
      department: json["department"],
      designation: json["designation"],
      qualification: json["qualification"] ?? "",
      workExp: json["work_exp"] ?? "",
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      fatherName: json["father_name"] ?? "",
      motherName: json["mother_name"] ?? "",
      contactNo: json["contact_no"] ?? "",
      emergencyContactNo: json["emergency_contact_no"] ?? "",
      email: json["email"] ?? "",
      dob: DateTime.tryParse(json["dob"] ?? ""),
      maritalStatus: json["marital_status"] ?? "",
      dateOfJoining: json["date_of_joining"] ?? "",
      dateOfLeaving: json["date_of_leaving"] ?? "",
      localAddress: json["local_address"] ?? "",
      permanentAddress: json["permanent_address"] ?? "",
      note: json["note"] ?? "",
      image: json["image"] ?? "",
      password: json["password"] ?? "",
      gender: json["gender"] ?? "",
      accountTitle: json["account_title"] ?? "",
      bankAccountNo: json["bank_account_no"] ?? "",
      bankName: json["bank_name"] ?? "",
      ifscCode: json["ifsc_code"] ?? "",
      bankBranch: json["bank_branch"] ?? "",
      payscale: json["payscale"] ?? "",
      basicSalary: json["basic_salary"] ?? "",
      epfNo: json["epf_no"] ?? "",
      contractType: json["contract_type"] ?? "",
      shift: json["shift"] ?? "",
      location: json["location"] ?? "",
      facebook: json["facebook"] ?? "",
      twitter: json["twitter"] ?? "",
      linkedin: json["linkedin"] ?? "",
      instagram: json["instagram"] ?? "",
      resume: json["resume"] ?? "",
      joiningLetter: json["joining_letter"] ?? "",
      resignationLetter: json["resignation_letter"] ?? "",
      otherDocumentName: json["other_document_name"] ?? "",
      otherDocumentFile: json["other_document_file"] ?? "",
      userId: json["user_id"] ?? "",
      isActive: json["is_active"],
      directManager: json["direct_manager"] ?? "",
      isHouseIncharge: json["is_house_incharge"] ?? "",
      verificationCode: json["verification_code"] ?? "",
      zoomApiKey: json["zoom_api_key"],
      zoomApiSecret: json["zoom_api_secret"],
      biometricDeviceId: json["biometric_device_id"] ?? "",
      disableAt: json["disable_at"],
      deviceId: json["device_id"] ?? "",
      tokenId: json["token_id"] ?? "",
      authToken: json["auth_token"],
      expiredAt: json["expired_at"],
      updatedAt: json["updated_at"],
      empid: json["empid"] ?? "",
      staffLeave: json["staff_leave"] == null ? [] : List<StaffLeave>.from(json["staff_leave"]!.map((x) => StaffLeave.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "lang_id": langId,
    "currency_id": currencyId,
    "department": department,
    "designation": designation,
    "qualification": qualification,
    "work_exp": workExp,
    "name": name,
    "surname": surname,
    "father_name": fatherName,
    "mother_name": motherName,
    "contact_no": contactNo,
    "emergency_contact_no": emergencyContactNo,
    "email": email,
    "dob": dob,
    "marital_status": maritalStatus,
    "date_of_joining": dateOfJoining,
    "date_of_leaving": dateOfLeaving,
    "local_address": localAddress,
    "permanent_address": permanentAddress,
    "note": note,
    "image": image,
    "password": password,
    "gender": gender,
    "account_title": accountTitle,
    "bank_account_no": bankAccountNo,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "bank_branch": bankBranch,
    "payscale": payscale,
    "basic_salary": basicSalary,
    "epf_no": epfNo,
    "contract_type": contractType,
    "shift": shift,
    "location": location,
    "facebook": facebook,
    "twitter": twitter,
    "linkedin": linkedin,
    "instagram": instagram,
    "resume": resume,
    "joining_letter": joiningLetter,
    "resignation_letter": resignationLetter,
    "other_document_name": otherDocumentName,
    "other_document_file": otherDocumentFile,
    "user_id": userId,
    "is_active": isActive,
    "direct_manager": directManager,
    "is_house_incharge": isHouseIncharge,
    "verification_code": verificationCode,
    "zoom_api_key": zoomApiKey,
    "zoom_api_secret": zoomApiSecret,
    "biometric_device_id": biometricDeviceId,
    "disable_at": disableAt,
    "device_id": deviceId,
    "token_id": tokenId,
    "auth_token": authToken,
    "expired_at": expiredAt,
    "updated_at": updatedAt,
    "empid": empid,
    "staff_leave": staffLeave.map((x) => x?.toJson()).toList(),
  };

}

class StaffLeave {
  StaffLeave({
    required this.id,
    required this.staffId,
    required this.leaveTypeId,
    required this.leaveFrom,
    required this.leaveTo,
    required this.leaveDays,
    required this.employeeRemark,
    required this.adminRemark,
    required this.status,
    required this.appliedBy,
    required this.documentFile,
    required this.date,
    required this.createdAt,
  });

  final String id;
  final String staffId;
  final String leaveTypeId;
  final String? leaveFrom;
  final String? leaveTo;
  final String leaveDays;
  final String employeeRemark;
  final String adminRemark;
  String status;
  final dynamic appliedBy;
  final String documentFile;
  final String date;
  final DateTime? createdAt;

  factory StaffLeave.fromJson(Map<String, dynamic> json){
    return StaffLeave(
      id: json["id"] ?? "",
      staffId: json["staff_id"] ?? "",
      leaveTypeId: json["leave_type_id"] ?? "",
      leaveFrom: json["leave_from"] ?? "",
      leaveTo: json["leave_to"] ?? "",
      leaveDays: json["leave_days"] ?? "",
      employeeRemark: json["employee_remark"] ?? "",
      adminRemark: json["admin_remark"] ?? "",
      status: json["status"] ?? "",
      appliedBy: json["applied_by"],
      documentFile: json["document_file"] ?? "",
      date: json["date"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "staff_id": staffId,
    "leave_type_id": leaveTypeId,
    "leave_from": leaveFrom,
    "leave_to": leaveTo,
    "leave_days": leaveDays,
    "employee_remark": employeeRemark,
    "admin_remark": adminRemark,
    "status": status,
    "applied_by": appliedBy,
    "document_file": documentFile,
    "date": date,
    "created_at": createdAt?.toIso8601String(),
  };

}

class StuLeave {
  StuLeave({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.classId,
    required this.sectionId,
    required this.subjectGroupId,
    required this.departmentId,
    required this.programId,
    required this.batchId,
    required this.batchPeriodId,
    required this.programPeriodCourseId,
    required this.hostelRoomId,
    required this.vehrouteId,
    required this.routePickupPointId,
    required this.transportFees,
    required this.feesDiscount,
    required this.isLeave,
    required this.isActive,
    required this.isAlumni,
    required this.defaultLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.parentId,
    required this.admissionNo,
    required this.rollNo,
    required this.admissionDate,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.rte,
    required this.image,
    required this.mobileno,
    required this.email,
    required this.state,
    required this.city,
    required this.pincode,
    required this.religion,
    required this.cast,
    required this.dob,
    required this.gender,
    required this.currentAddress,
    required this.permanentAddress,
    required this.categoryId,
    required this.schoolHouseId,
    required this.bloodGroup,
    required this.roomBedId,
    required this.adharNo,
    required this.samagraId,
    required this.bankAccountNo,
    required this.bankName,
    required this.ifscCode,
    required this.guardianIs,
    required this.fatherName,
    required this.fatherPhone,
    required this.fatherOccupation,
    required this.motherName,
    required this.motherPhone,
    required this.motherOccupation,
    required this.guardianName,
    required this.guardianRelation,
    required this.guardianPhone,
    required this.guardianOccupation,
    required this.guardianAddress,
    required this.guardianEmail,
    required this.fatherPic,
    required this.motherPic,
    required this.guardianPic,
    required this.previousSchool,
    required this.height,
    required this.weight,
    required this.measurementDate,
    required this.disReason,
    required this.note,
    required this.disNote,
    required this.appKey,
    required this.parentAppKey,
    required this.disableAt,
    required this.faceAuth,
    required this.ssid,
    required this.studentsLeave,
  });

  final String id;
  final String sessionId;
  final String studentId;
  final String classId;
  final String sectionId;
  final String subjectGroupId;
  final String departmentId;
  final dynamic programId;
  final dynamic batchId;
  final dynamic batchPeriodId;
  final dynamic programPeriodCourseId;
  final String hostelRoomId;
  final String vehrouteId;
  final String routePickupPointId;
  final String transportFees;
  final String feesDiscount;
  final String isLeave;
  final String isActive;
  final String isAlumni;
  final String defaultLogin;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final String parentId;
  final String admissionNo;
  final String rollNo;
  final DateTime? admissionDate;
  final String firstname;
  final dynamic middlename;
  final String lastname;
  final String rte;
  final String image;
  final String mobileno;
  final String email;
  final dynamic state;
  final dynamic city;
  final dynamic pincode;
  final String religion;
  final String cast;
  final DateTime? dob;
  final String gender;
  final String currentAddress;
  final String permanentAddress;
  final String categoryId;
  final String schoolHouseId;
  final String bloodGroup;
  final String roomBedId;
  final String adharNo;
  final String samagraId;
  final String bankAccountNo;
  final String bankName;
  final String ifscCode;
  final String guardianIs;
  final String fatherName;
  final String fatherPhone;
  final String fatherOccupation;
  final String motherName;
  final String motherPhone;
  final String motherOccupation;
  final String guardianName;
  final String guardianRelation;
  final String guardianPhone;
  final String guardianOccupation;
  final String guardianAddress;
  final String guardianEmail;
  final String fatherPic;
  final String motherPic;
  final String guardianPic;
  final String previousSchool;
  final String height;
  final String weight;
  final DateTime? measurementDate;
  final String disReason;
  final String note;
  final String disNote;
  final dynamic appKey;
  final dynamic parentAppKey;
  final DateTime? disableAt;
  final String faceAuth;
  final String ssid;
  final List<StudentsLeave> studentsLeave;

  factory StuLeave.fromJson(Map<String, dynamic> json){
    return StuLeave(
      id: json["id"] ?? "",
      sessionId: json["session_id"] ?? "",
      studentId: json["student_id"] ?? "",
      classId: json["class_id"] ?? "",
      sectionId: json["section_id"] ?? "",
      subjectGroupId: json["subject_group_id"] ?? "",
      departmentId: json["department_id"] ?? "",
      programId: json["program_id"],
      batchId: json["batch_id"],
      batchPeriodId: json["batch_period_id"],
      programPeriodCourseId: json["program_period_course_id"],
      hostelRoomId: json["hostel_room_id"] ?? "",
      vehrouteId: json["vehroute_id"] ?? "",
      routePickupPointId: json["route_pickup_point_id"] ?? "",
      transportFees: json["transport_fees"] ?? "",
      feesDiscount: json["fees_discount"] ?? "",
      isLeave: json["is_leave"] ?? "",
      isActive: json["is_active"] ?? "",
      isAlumni: json["is_alumni"] ?? "",
      defaultLogin: json["default_login"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: json["updated_at"],
      parentId: json["parent_id"] ?? "",
      admissionNo: json["admission_no"] ?? "",
      rollNo: json["roll_no"] ?? "",
      admissionDate: DateTime.tryParse(json["admission_date"] ?? ""),
      firstname: json["firstname"] ?? "",
      middlename: json["middlename"],
      lastname: json["lastname"] ?? "",
      rte: json["rte"] ?? "",
      image: json["image"] ?? "",
      mobileno: json["mobileno"] ?? "",
      email: json["email"] ?? "",
      state: json["state"],
      city: json["city"],
      pincode: json["pincode"],
      religion: json["religion"] ?? "",
      cast: json["cast"] ?? "",
      dob: DateTime.tryParse(json["dob"] ?? ""),
      gender: json["gender"] ?? "",
      currentAddress: json["current_address"] ?? "",
      permanentAddress: json["permanent_address"] ?? "",
      categoryId: json["category_id"] ?? "",
      schoolHouseId: json["school_house_id"] ?? "",
      bloodGroup: json["blood_group"] ?? "",
      roomBedId: json["room_bed_id"] ?? "",
      adharNo: json["adhar_no"] ?? "",
      samagraId: json["samagra_id"] ?? "",
      bankAccountNo: json["bank_account_no"] ?? "",
      bankName: json["bank_name"] ?? "",
      ifscCode: json["ifsc_code"] ?? "",
      guardianIs: json["guardian_is"] ?? "",
      fatherName: json["father_name"] ?? "",
      fatherPhone: json["father_phone"] ?? "",
      fatherOccupation: json["father_occupation"] ?? "",
      motherName: json["mother_name"] ?? "",
      motherPhone: json["mother_phone"] ?? "",
      motherOccupation: json["mother_occupation"] ?? "",
      guardianName: json["guardian_name"] ?? "",
      guardianRelation: json["guardian_relation"] ?? "",
      guardianPhone: json["guardian_phone"] ?? "",
      guardianOccupation: json["guardian_occupation"] ?? "",
      guardianAddress: json["guardian_address"] ?? "",
      guardianEmail: json["guardian_email"] ?? "",
      fatherPic: json["father_pic"] ?? "",
      motherPic: json["mother_pic"] ?? "",
      guardianPic: json["guardian_pic"] ?? "",
      previousSchool: json["previous_school"] ?? "",
      height: json["height"] ?? "",
      weight: json["weight"] ?? "",
      measurementDate: DateTime.tryParse(json["measurement_date"] ?? ""),
      disReason: json["dis_reason"] ?? "",
      note: json["note"] ?? "",
      disNote: json["dis_note"] ?? "",
      appKey: json["app_key"],
      parentAppKey: json["parent_app_key"],
      disableAt: DateTime.tryParse(json["disable_at"] ?? ""),
      faceAuth: json["face_auth"] ?? "",
      ssid: json["ssid"] ?? "",
      studentsLeave: json["students_leave"] == null ? [] : List<StudentsLeave>.from(json["students_leave"]!.map((x) => StudentsLeave.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "session_id": sessionId,
    "student_id": studentId,
    "class_id": classId,
    "section_id": sectionId,
    "subject_group_id": subjectGroupId,
    "department_id": departmentId,
    "program_id": programId,
    "batch_id": batchId,
    "batch_period_id": batchPeriodId,
    "program_period_course_id": programPeriodCourseId,
    "hostel_room_id": hostelRoomId,
    "vehroute_id": vehrouteId,
    "route_pickup_point_id": routePickupPointId,
    "transport_fees": transportFees,
    "fees_discount": feesDiscount,
    "is_leave": isLeave,
    "is_active": isActive,
    "is_alumni": isAlumni,
    "default_login": defaultLogin,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "parent_id": parentId,
    "admission_no": admissionNo,
    "roll_no": rollNo,
    "admission_date": admissionDate,
    "firstname": firstname,
    "middlename": middlename,
    "lastname": lastname,
    "rte": rte,
    "image": image,
    "mobileno": mobileno,
    "email": email,
    "state": state,
    "city": city,
    "pincode": pincode,
    "religion": religion,
    "cast": cast,
    "dob": "dob",
    "gender": gender,
    "current_address": currentAddress,
    "permanent_address": permanentAddress,
    "category_id": categoryId,
    "school_house_id": schoolHouseId,
    "blood_group": bloodGroup,
    "room_bed_id": roomBedId,
    "adhar_no": adharNo,
    "samagra_id": samagraId,
    "bank_account_no": bankAccountNo,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "guardian_is": guardianIs,
    "father_name": fatherName,
    "father_phone": fatherPhone,
    "father_occupation": fatherOccupation,
    "mother_name": motherName,
    "mother_phone": motherPhone,
    "mother_occupation": motherOccupation,
    "guardian_name": guardianName,
    "guardian_relation": guardianRelation,
    "guardian_phone": guardianPhone,
    "guardian_occupation": guardianOccupation,
    "guardian_address": guardianAddress,
    "guardian_email": guardianEmail,
    "father_pic": fatherPic,
    "mother_pic": motherPic,
    "guardian_pic": guardianPic,
    "previous_school": previousSchool,
    "height": height,
    "weight": weight,
    "measurement_date": measurementDate,
    "dis_reason": disReason,
    "note": note,
    "dis_note": disNote,
    "app_key": appKey,
    "parent_app_key": parentAppKey,
    "disable_at": disableAt,
    "face_auth": faceAuth,
    "ssid": ssid,
    "students_leave": studentsLeave.map((x) => x.toJson()).toList(),
  };

}

class StudentsLeave {
  StudentsLeave({
    required this.id,
    required this.studentSessionId,
    required this.fromDate,
    required this.toDate,
    required this.applyDate,
    required this.status,
    required this.docs,
    required this.reason,
    required this.approveBy,
    required this.approveDate,
    required this.requestType,
    required this.createdAt,
  });

  final String id;
  final String studentSessionId;
  final String? fromDate;
  final String? toDate;
  final DateTime? applyDate;
  String status;
  final dynamic docs;
  final String reason;
  final dynamic approveBy;
  final dynamic approveDate;
  final String requestType;
  final DateTime? createdAt;

  factory StudentsLeave.fromJson(Map<String, dynamic> json){
    return StudentsLeave(
      id: json["id"] ?? "",
      studentSessionId: json["student_session_id"] ?? "",
      fromDate: json["from_date"] ?? "",
      toDate: json["to_date"] ?? "",
      applyDate: DateTime.tryParse(json["apply_date"] ?? ""),
      status: json["status"] ?? "",
      docs: json["docs"],
      reason: json["reason"] ?? "",
      approveBy: json["approve_by"],
      approveDate: json["approve_date"],
      requestType: json["request_type"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_session_id": studentSessionId,
    "from_date": fromDate,
    "to_date": toDate,
    "apply_date": applyDate,
    "status": status,
    "docs": docs,
    "reason": reason,
    "approve_by": approveBy,
    "approve_date": approveDate,
    "request_type": requestType,
    "created_at": createdAt?.toIso8601String(),
  };

}
