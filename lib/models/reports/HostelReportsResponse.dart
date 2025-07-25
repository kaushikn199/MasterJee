class Hostelreportsresponse {
  final String status;
  final String message;
  final bool result;
  final List<StudentModel> data;

  Hostelreportsresponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,

  });

  factory Hostelreportsresponse.fromJson(Map<String, dynamic> json) {
    return Hostelreportsresponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] != null && json['data'] is List)
          ? (json['data'] as List)
          .map((e) => StudentModel.fromJson(e))
          .toList()
          : [],
    );
  }
}

class LoginInfo {
  final String id;
  final String userId;
  final String username;
  final String password;
  final String childs;
  final String role;
  final String langId;
  final String currencyId;
  final String verificationCode;
  final String isActive;
  final String createdAt;
  final String? updatedAt;

  LoginInfo({
    required this.id,
    required this.userId,
    required this.username,
    required this.password,
    required this.childs,
    required this.role,
    required this.langId,
    required this.currencyId,
    required this.verificationCode,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      childs: json['childs'] ?? '',
      role: json['role'] ?? '',
      langId: json['lang_id'] ?? '',
      currencyId: json['currency_id'] ?? '',
      verificationCode: json['verification_code'] ?? '',
      isActive: json['is_active'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "username": username,
      "password": password,
      "childs": childs,
      "role": role,
      "lang_id": langId,
      "currency_id": currencyId,
      "verification_code": verificationCode,
      "is_active": isActive,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

class StudentModel {
  final LoginInfo loginInfo;
  final String? id;
  final String? sessionId;
  final String? studentId;
  final String? classId;
  final String? sectionId;
  final String? subjectGroupId;
  final String? departmentId;
  final String? programId;
  final String? batchId;
  final String? batchPeriodId;
  final String? programPeriodCourseId;
  final String? hostelRoomId;
  final String? vehrouteId;
  final String? routePickupPointId;
  final String? transportFees;
  final String? feesDiscount;
  final String? isLeave;
  final String? isActive;
  final String? isAlumni;
  final String? defaultLogin;
  final String? createdAt;
  final String? updatedAt;
  final String? parentId;
  final String? admissionNo;
  final String? rollNo;
  final String? admissionDate;
  final String? firstname;
  final String? middlename;
  final String? lastname;
  final String? rte;
  final String? image;
  final String? mobileno;
  final String? email;
  final String? state;
  final String? city;
  final String? pincode;
  final String? religion;
  final String? cast;
  final String? dob;
  final String? gender;
  final String? currentAddress;
  final String? permanentAddress;
  final String? categoryId;
  final String? schoolHouseId;
  final String? bloodGroup;
  final String? roomBedId;
  final String? adharNo;
  final String? samagraId;
  final String? bankAccountNo;
  final String? bankName;
  final String? ifscCode;
  final String? guardianIs;
  final String? fatherName;
  final String? fatherPhone;
  final String? fatherOccupation;
  final String? motherName;
  final String? motherPhone;
  final String? motherOccupation;
  final String? guardianName;
  final String? guardianRelation;
  final String? guardianPhone;
  final String? guardianOccupation;
  final String? guardianAddress;
  final String? guardianEmail;
  final String? fatherPic;
  final String? motherPic;
  final String? guardianPic;
  final String? previousSchool;
  final String? height;
  final String? weight;
  final String? measurementDate;
  final String? disReason;
  final String? note;
  final String? disNote;
  final String? appKey;
  final String? parentAppKey;
  final String? disableAt;
  final String? faceAuth;
  final String? ssid;
  final String? costPerBed;
  final HostelInfoModel? hostelInfo;

  StudentModel({
    required this.loginInfo,
    this.id,
    this.sessionId,
    this.studentId,
    this.classId,
    this.sectionId,
    this.subjectGroupId,
    this.departmentId,
    this.programId,
    this.batchId,
    this.batchPeriodId,
    this.programPeriodCourseId,
    this.hostelRoomId,
    this.vehrouteId,
    this.routePickupPointId,
    this.transportFees,
    this.feesDiscount,
    this.isLeave,
    this.isActive,
    this.isAlumni,
    this.defaultLogin,
    this.createdAt,
    this.updatedAt,
    this.parentId,
    this.admissionNo,
    this.rollNo,
    this.admissionDate,
    this.firstname,
    this.middlename,
    this.lastname,
    this.rte,
    this.image,
    this.mobileno,
    this.email,
    this.state,
    this.city,
    this.pincode,
    this.religion,
    this.cast,
    this.dob,
    this.gender,
    this.currentAddress,
    this.permanentAddress,
    this.categoryId,
    this.schoolHouseId,
    this.bloodGroup,
    this.roomBedId,
    this.adharNo,
    this.samagraId,
    this.bankAccountNo,
    this.bankName,
    this.ifscCode,
    this.guardianIs,
    this.fatherName,
    this.fatherPhone,
    this.fatherOccupation,
    this.motherName,
    this.motherPhone,
    this.motherOccupation,
    this.guardianName,
    this.guardianRelation,
    this.guardianPhone,
    this.guardianOccupation,
    this.guardianAddress,
    this.guardianEmail,
    this.fatherPic,
    this.motherPic,
    this.guardianPic,
    this.previousSchool,
    this.height,
    this.weight,
    this.measurementDate,
    this.disReason,
    this.note,
    this.disNote,
    this.appKey,
    this.parentAppKey,
    this.disableAt,
    this.faceAuth,
    this.ssid,
    this.hostelInfo,
    this.costPerBed,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      sessionId: json['session_id'],
      studentId: json['student_id'],
      classId: json['class_id'],
      sectionId: json['section_id'],
      subjectGroupId: json['subject_group_id'],
      departmentId: json['department_id'],
      programId: json['program_id'],
      batchId: json['batch_id'],
      batchPeriodId: json['batch_period_id'],
      programPeriodCourseId: json['program_period_course_id'],
      hostelRoomId: json['hostel_room_id'],
      vehrouteId: json['vehroute_id'],
      routePickupPointId: json['route_pickup_point_id'],
      transportFees: json['transport_fees'],
      feesDiscount: json['fees_discount'],
      isLeave: json['is_leave'],
      isActive: json['is_active'],
      isAlumni: json['is_alumni'],
      defaultLogin: json['default_login'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      parentId: json['parent_id'],
      admissionNo: json['admission_no'],
      rollNo: json['roll_no'],
      admissionDate: json['admission_date'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      rte: json['rte'],
      image: json['image'],
      mobileno: json['mobileno'],
      email: json['email'],
      state: json['state'],
      city: json['city'],
      pincode: json['pincode'],
      religion: json['religion'],
      cast: json['cast'],
      dob: json['dob'],
      gender: json['gender'],
      currentAddress: json['current_address'],
      permanentAddress: json['permanent_address'],
      categoryId: json['category_id'],
      schoolHouseId: json['school_house_id'],
      bloodGroup: json['blood_group'],
      roomBedId: json['room_bed_id'],
      adharNo: json['adhar_no'],
      samagraId: json['samagra_id'],
      bankAccountNo: json['bank_account_no'],
      bankName: json['bank_name'],
      ifscCode: json['ifsc_code'],
      guardianIs: json['guardian_is'],
      fatherName: json['father_name'],
      fatherPhone: json['father_phone'],
      fatherOccupation: json['father_occupation'],
      motherName: json['mother_name'],
      motherPhone: json['mother_phone'],
      motherOccupation: json['mother_occupation'],
      guardianName: json['guardian_name'],
      guardianRelation: json['guardian_relation'],
      guardianPhone: json['guardian_phone'],
      guardianOccupation: json['guardian_occupation'],
      guardianAddress: json['guardian_address'],
      guardianEmail: json['guardian_email'],
      fatherPic: json['father_pic'],
      motherPic: json['mother_pic'],
      guardianPic: json['guardian_pic'],
      previousSchool: json['previous_school'],
      height: json['height'],
      weight: json['weight'],
      measurementDate: json['measurement_date'],
      disReason: json['dis_reason'],
      note: json['note'],
      disNote: json['dis_note'],
      appKey: json['app_key'],
      parentAppKey: json['parent_app_key'],
      disableAt: json['disable_at'],
      faceAuth: json['face_auth'],
      ssid: json['ssid'],
      costPerBed: json['cost_per_bed'],
      hostelInfo: json['hostelInfo'] != null ? HostelInfoModel.fromJson(json['hostelInfo']) : null,
      loginInfo: LoginInfo.fromJson(json['loginInfo'] ?? {}),
    );
  }
}

class HostelInfoModel {
  final String? id;
  final String? hostelId;
  final String? parentId;
  final String? admissionNo;
  final String? rollNo;
  final String? admissionDate;
  final String? firstname;
  final String? middlename;
  final String? lastname;
  final String? rte;
  final String? image;
  final String? type;
  final String? mobileno;
  final String? email;
  final String? dob;
  final String? gender;
  final String? roomBedId;
  final String? guardianName;
  final String? guardianPhone;
  final String? address;
  final String? height;
  final String? weight;
  final String? measurementDate;
  final String? isActive;
  final String? hostelName;
  final String? roomNo;
  final String? bedCode;
  final String? bedStatus;
  final String? description;
  final String? roomType;
  final String? costPerBed;
  final String? password;
  final String? username;

  HostelInfoModel({
    this.id,
    this.hostelId,
    this.parentId,
    this.admissionNo,
    this.rollNo,
    this.admissionDate,
    this.firstname,
    this.middlename,
    this.lastname,
    this.rte,
    this.image,
    this.mobileno,
    this.email,
    this.dob,
    this.gender,
    this.roomBedId,
    this.guardianName,
    this.guardianPhone,
    this.address,
    this.height,
    this.weight,
    this.measurementDate,
    this.isActive,
    this.hostelName,
    this.roomNo,
    this.bedCode,
    this.bedStatus,
    this.description,
    this.roomType,
    this.type,
    this.costPerBed,
    this.password,
    this.username,
  });

  factory HostelInfoModel.fromJson(Map<String, dynamic> json) {
    return HostelInfoModel(
      id: json['id'],
      hostelId: json['hostel_id'],
      parentId: json['parent_id'],
      admissionNo: json['admission_no'],
      rollNo: json['roll_no'],
      admissionDate: json['admission_date'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      rte: json['rte'],
      image: json['image'],
      mobileno: json['mobileno'],
      email: json['email'],
      dob: json['dob'],
      gender: json['gender'],
      roomBedId: json['room_bed_id'],
      guardianName: json['guardian_name'],
      guardianPhone: json['guardian_phone'],
      address: json['guardian_address'],
      height: json['height'],
      weight: json['weight'],
      measurementDate: json['measurement_date'],
      isActive: json['is_active'],
      hostelName: json['hostel_name'],
      roomNo: json['room_no'],
      bedCode: json['bed_code'],
      bedStatus: json['bed_status'],
      description: json['description'],
      roomType: json['room_type'],
      type: json['type'],
      costPerBed: json['cost_per_bed'],
      password: json['password'],
      username: json['username'],
    );
  }
}