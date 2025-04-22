class DuesReportResponse {
  DuesReportResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  final String status;
  final String message;
  final List<DuesReportData> data;
  final bool result;

  factory DuesReportResponse.fromJson(Map<String, dynamic> json){
    return DuesReportResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<DuesReportData>.from(json["data"]!.map((x) => DuesReportData.fromJson(x))),
      result: json["result"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "result": result,
  };

}

class DuesReportData {
  DuesReportData({
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
    required this.payble,
    required this.discount,
    required this.deposit,
    required this.dues,
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
  final int payble;
  final int discount;
  final int deposit;
  final int dues;

  factory DuesReportData.fromJson(Map<String, dynamic> json){
    return DuesReportData(
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
      payble: json["payble"] ?? 0,
      discount: json["discount"] ?? 0,
      deposit: json["deposit"] ?? 0,
      dues: json["dues"] ?? 0,
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
    "admission_date": "${admissionDate?.year.toString().padLeft(4)}-${admissionDate?.month.toString().padLeft(2)}-${admissionDate?.day.toString().padLeft(2)}",
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
    "dob": "${dob?.year.toString().padLeft(4)}-${dob?.month.toString().padLeft(2)}-${dob?.day.toString().padLeft(2)}",
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
    "measurement_date": "${measurementDate?.year.toString().padLeft(4)}-${measurementDate?.month.toString().padLeft(2)}-${measurementDate?.day.toString().padLeft(2)}",
    "dis_reason": disReason,
    "note": note,
    "dis_note": disNote,
    "app_key": appKey,
    "parent_app_key": parentAppKey,
    "disable_at": "${disableAt?.year.toString().padLeft(4)}-${disableAt?.month.toString().padLeft(2)}-${disableAt?.day.toString().padLeft(2)}",
    "face_auth": faceAuth,
    "ssid": ssid,
    "payble": payble,
    "discount": discount,
    "deposit": deposit,
    "dues": dues,
  };

}
