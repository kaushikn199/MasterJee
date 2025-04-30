class AttendanceReportResponse {
  final String status;
  final String message;
  final List<AttendanceReportData> data;
  final bool result;

  AttendanceReportResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory AttendanceReportResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceReportResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => AttendanceReportData.fromJson(e))
          .toList(),
      result: json['result'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
      'result': result,
    };
  }
}

class AttendanceReportData {
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
  final String? attendance;

  AttendanceReportData({
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
    this.attendance,
  });

  factory AttendanceReportData.fromJson(Map<String, dynamic> json) => AttendanceReportData(
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
    attendance: json['attendance'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'session_id': sessionId,
    'student_id': studentId,
    'class_id': classId,
    'section_id': sectionId,
    'subject_group_id': subjectGroupId,
    'department_id': departmentId,
    'program_id': programId,
    'batch_id': batchId,
    'batch_period_id': batchPeriodId,
    'program_period_course_id': programPeriodCourseId,
    'hostel_room_id': hostelRoomId,
    'vehroute_id': vehrouteId,
    'route_pickup_point_id': routePickupPointId,
    'transport_fees': transportFees,
    'fees_discount': feesDiscount,
    'is_leave': isLeave,
    'is_active': isActive,
    'is_alumni': isAlumni,
    'default_login': defaultLogin,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'parent_id': parentId,
    'admission_no': admissionNo,
    'roll_no': rollNo,
    'admission_date': admissionDate,
    'firstname': firstname,
    'middlename': middlename,
    'lastname': lastname,
    'rte': rte,
    'image': image,
    'mobileno': mobileno,
    'email': email,
    'state': state,
    'city': city,
    'pincode': pincode,
    'religion': religion,
    'cast': cast,
    'dob': dob,
    'gender': gender,
    'current_address': currentAddress,
    'permanent_address': permanentAddress,
    'category_id': categoryId,
    'school_house_id': schoolHouseId,
    'blood_group': bloodGroup,
    'room_bed_id': roomBedId,
    'adhar_no': adharNo,
    'samagra_id': samagraId,
    'bank_account_no': bankAccountNo,
    'bank_name': bankName,
    'ifsc_code': ifscCode,
    'guardian_is': guardianIs,
    'father_name': fatherName,
    'father_phone': fatherPhone,
    'father_occupation': fatherOccupation,
    'mother_name': motherName,
    'mother_phone': motherPhone,
    'mother_occupation': motherOccupation,
    'guardian_name': guardianName,
    'guardian_relation': guardianRelation,
    'guardian_phone': guardianPhone,
    'guardian_occupation': guardianOccupation,
    'guardian_address': guardianAddress,
    'guardian_email': guardianEmail,
    'father_pic': fatherPic,
    'mother_pic': motherPic,
    'guardian_pic': guardianPic,
    'previous_school': previousSchool,
    'height': height,
    'weight': weight,
    'measurement_date': measurementDate,
    'dis_reason': disReason,
    'note': note,
    'dis_note': disNote,
    'app_key': appKey,
    'parent_app_key': parentAppKey,
    'disable_at': disableAt,
    'face_auth': faceAuth,
    'ssid': ssid,
    'attendance': attendance,
  };
}
