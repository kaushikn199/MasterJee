class AllStudentsResponse {
  String status;
  String message;
  bool result;
  List<StudentData>? data;

  AllStudentsResponse({
    required this.status,
    required this.message,
    required this.result,
    this.data,
  });

  factory AllStudentsResponse.fromJson(Map<String, dynamic> json) {
    return AllStudentsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: json['data'] != null
          ? List<StudentData>.from(json['data'].map((x) => StudentData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'result': result,
    'data': data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
  };
}


class StudentData {
  String id;
  String sessionId;
  String studentId;
  String classId;
  String sectionId;
  String subjectGroupId;
  String? departmentId;
  String? programId;
  String? batchId;
  String? batchPeriodId;
  String? programPeriodCourseId;
  String hostelRoomId;
  String? vehrouteId;
  String? routePickupPointId;
  String transportFees;
  String feesDiscount;
  String isLeave;
  String isActive;
  String isAlumni;
  String defaultLogin;
  String createdAt;
  String? updatedAt;
  String parentId;
  String admissionNo;
  String rollNo;
  String admissionDate;
  String firstname;
  String? middlename;
  String lastname;
  String rte;
  String image;
  String mobileno;
  String email;
  String? state;
  String? city;
  String? pincode;
  String religion;
  String cast;
  String dob;
  String gender;
  String currentAddress;
  String permanentAddress;
  String categoryId;
  String schoolHouseId;
  String bloodGroup;
  String roomBedId;
  String adharNo;
  String samagraId;
  String bankAccountNo;
  String bankName;
  String ifscCode;
  String guardianIs;
  String fatherName;
  String fatherPhone;
  String fatherOccupation;
  String motherName;
  String motherPhone;
  String motherOccupation;
  String guardianName;
  String guardianRelation;
  String guardianPhone;
  String guardianOccupation;
  String guardianAddress;
  String guardianEmail;
  String fatherPic;
  String motherPic;
  String guardianPic;
  String previousSchool;
  String height;
  String weight;
  String measurementDate;
  String disReason;
  String note;
  String disNote;
  String? appKey;
  String? parentAppKey;
  String? disableAt;
  String faceAuth;
  String ssid;
  int? selectedValue;
  String? selectedValueText;

  StudentData({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.classId,
    required this.sectionId,
    required this.subjectGroupId,
    this.departmentId,
    this.programId,
    this.batchId,
    this.batchPeriodId,
    this.programPeriodCourseId,
    required this.hostelRoomId,
    this.vehrouteId,
    this.routePickupPointId,
    required this.transportFees,
    required this.feesDiscount,
    required this.isLeave,
    required this.isActive,
    required this.isAlumni,
    required this.defaultLogin,
    required this.createdAt,
    this.updatedAt,
    required this.parentId,
    required this.admissionNo,
    required this.rollNo,
    required this.admissionDate,
    required this.firstname,
    this.middlename,
    required this.lastname,
    required this.rte,
    required this.image,
    required this.mobileno,
    required this.email,
    this.state,
    this.city,
    this.pincode,
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
    this.appKey,
    this.parentAppKey,
    this.disableAt,
    required this.faceAuth,
    required this.ssid,
    this.selectedValue,
    this.selectedValueText,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
    id: json["id"],
    sessionId: json["session_id"],
    studentId: json["student_id"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    subjectGroupId: json["subject_group_id"],
    departmentId: json["department_id"],
    programId: json["program_id"],
    batchId: json["batch_id"],
    batchPeriodId: json["batch_period_id"],
    programPeriodCourseId: json["program_period_course_id"],
    hostelRoomId: json["hostel_room_id"],
    vehrouteId: json["vehroute_id"],
    routePickupPointId: json["route_pickup_point_id"],
    transportFees: json["transport_fees"],
    feesDiscount: json["fees_discount"],
    isLeave: json["is_leave"],
    isActive: json["is_active"],
    isAlumni: json["is_alumni"],
    defaultLogin: json["default_login"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    parentId: json["parent_id"],
    admissionNo: json["admission_no"],
    rollNo: json["roll_no"],
    admissionDate: json["admission_date"],
    firstname: json["firstname"],
    middlename: json["middlename"],
    lastname: json["lastname"],
    rte: json["rte"],
    image: json["image"],
    mobileno: json["mobileno"],
    email: json["email"],
    state: json["state"],
    city: json["city"],
    pincode: json["pincode"],
    religion: json["religion"] ?? "",
    cast: json["cast"] ?? "",
    dob: json["dob"],
    gender: json["gender"],
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
    guardianIs: json["guardian_is"],
    fatherName: json["father_name"],
    fatherPhone: json["father_phone"],
    fatherOccupation: json["father_occupation"] ?? "",
    motherName: json["mother_name"] ?? "",
    motherPhone: json["mother_phone"] ?? "",
    motherOccupation: json["mother_occupation"] ?? "",
    guardianName: json["guardian_name"],
    guardianRelation: json["guardian_relation"],
    guardianPhone: json["guardian_phone"],
    guardianOccupation: json["guardian_occupation"] ?? "",
    guardianAddress: json["guardian_address"] ?? "",
    guardianEmail: json["guardian_email"] ?? "",
    fatherPic: json["father_pic"] ?? "",
    motherPic: json["mother_pic"] ?? "",
    guardianPic: json["guardian_pic"] ?? "",
    previousSchool: json["previous_school"] ?? "",
    height: json["height"] ?? "",
    weight: json["weight"] ?? "",
    measurementDate: json["measurement_date"],
    disReason: json["dis_reason"],
    note: json["note"],
    disNote: json["dis_note"],
    appKey: json["app_key"],
    parentAppKey: json["parent_app_key"],
    disableAt: json["disable_at"],
    faceAuth: json["face_auth"],
    ssid: json["ssid"],
    selectedValue: json["selectedValue"],
    selectedValueText: json["selectedValueText"] ?? "Present",
  );

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
    "created_at": createdAt,
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
    "dob": dob,
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
    "selectedValue": selectedValue,
    "selectedValueText": selectedValueText,
  };
}