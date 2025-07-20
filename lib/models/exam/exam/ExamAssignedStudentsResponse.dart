class ExamAssignedStudentsResponse {
  final String status;
  final String message;
  final bool result;
  final List<ExamAssignedStudentsData> data;

  ExamAssignedStudentsResponse({
    this.status = '',
    this.message = '',
    this.result = false,
    this.data = const [],
  });

  factory ExamAssignedStudentsResponse.fromJson(Map<String, dynamic> json) {
    return ExamAssignedStudentsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExamAssignedStudentsData.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'result': result,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class ExamAssignedStudentsData {
  final String id;
  final String cbseExamId;
  final String studentSessionId;
  final String? roomNumber;
  final String staffId;
  final String rollNo;
  final String remark;
  final String totalPresentDays;
  final String deleteStudentId;
  final String createdAt;
  final String sessionId;
  final String studentId;
  final String classId;
  final String sectionId;
  final String subjectGroupId;
  final String? departmentId;
  final String? programId;
  final String? batchId;
  final String? batchPeriodId;
  final String? programPeriodCourseId;
  final String hostelRoomId;
  final String vehrouteId;
  final String routePickupPointId;
  final String transportFees;
  final String feesDiscount;
  final String isLeave;
  final String isActive;
  final String isAlumni;
  final String defaultLogin;
  final String? updatedAt;
  final String parentId;
  final String admissionNo;
  final String admissionDate;
  final String firstname;
  final String? middlename;
  final String lastname;
  final String rte;
  final String image;
  final String mobileno;
  final String email;
  final String? state;
  final String? city;
  final String? pincode;
  final String religion;
  final String cast;
  final String dob;
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
  final String measurementDate;
  final String disReason;
  final String note;
  final String disNote;
  final String? appKey;
  final String? parentAppKey;
  final String disableAt;
  final String faceAuth;
  final String esid;

  ExamAssignedStudentsData({
    this.id = '',
    this.cbseExamId = '',
    this.studentSessionId = '',
    this.roomNumber,
    this.staffId = '',
    this.rollNo = '',
    this.remark = '',
    this.totalPresentDays = '',
    this.deleteStudentId = '',
    this.createdAt = '',
    this.sessionId = '',
    this.studentId = '',
    this.classId = '',
    this.sectionId = '',
    this.subjectGroupId = '',
    this.departmentId,
    this.programId,
    this.batchId,
    this.batchPeriodId,
    this.programPeriodCourseId,
    this.hostelRoomId = '',
    this.vehrouteId = '',
    this.routePickupPointId = '',
    this.transportFees = '',
    this.feesDiscount = '',
    this.isLeave = '',
    this.isActive = '',
    this.isAlumni = '',
    this.defaultLogin = '',
    this.updatedAt,
    this.parentId = '',
    this.admissionNo = '',
    this.admissionDate = '',
    this.firstname = '',
    this.middlename,
    this.lastname = '',
    this.rte = '',
    this.image = '',
    this.mobileno = '',
    this.email = '',
    this.state,
    this.city,
    this.pincode,
    this.religion = '',
    this.cast = '',
    this.dob = '',
    this.gender = '',
    this.currentAddress = '',
    this.permanentAddress = '',
    this.categoryId = '',
    this.schoolHouseId = '',
    this.bloodGroup = '',
    this.roomBedId = '',
    this.adharNo = '',
    this.samagraId = '',
    this.bankAccountNo = '',
    this.bankName = '',
    this.ifscCode = '',
    this.guardianIs = '',
    this.fatherName = '',
    this.fatherPhone = '',
    this.fatherOccupation = '',
    this.motherName = '',
    this.motherPhone = '',
    this.motherOccupation = '',
    this.guardianName = '',
    this.guardianRelation = '',
    this.guardianPhone = '',
    this.guardianOccupation = '',
    this.guardianAddress = '',
    this.guardianEmail = '',
    this.fatherPic = '',
    this.motherPic = '',
    this.guardianPic = '',
    this.previousSchool = '',
    this.height = '',
    this.weight = '',
    this.measurementDate = '',
    this.disReason = '',
    this.note = '',
    this.disNote = '',
    this.appKey,
    this.parentAppKey,
    this.disableAt = '',
    this.faceAuth = '',
    this.esid = '',
  });

  factory ExamAssignedStudentsData.fromJson(Map<String, dynamic> json) {
    return ExamAssignedStudentsData(
      id: json['id'] ?? '',
      cbseExamId: json['cbse_exam_id'] ?? '',
      studentSessionId: json['student_session_id'] ?? '',
      roomNumber: json['room_number'],
      staffId: json['staff_id'] ?? '',
      rollNo: json['roll_no'] ?? '',
      remark: json['remark'] ?? '',
      totalPresentDays: json['total_present_days'] ?? '',
      deleteStudentId: json['delete_student_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      sessionId: json['session_id'] ?? '',
      studentId: json['student_id'] ?? '',
      classId: json['class_id'] ?? '',
      sectionId: json['section_id'] ?? '',
      subjectGroupId: json['subject_group_id'] ?? '',
      departmentId: json['department_id'],
      programId: json['program_id'],
      batchId: json['batch_id'],
      batchPeriodId: json['batch_period_id'],
      programPeriodCourseId: json['program_period_course_id'],
      hostelRoomId: json['hostel_room_id'] ?? '',
      vehrouteId: json['vehroute_id'] ?? '',
      routePickupPointId: json['route_pickup_point_id'] ?? '',
      transportFees: json['transport_fees'] ?? '',
      feesDiscount: json['fees_discount'] ?? '',
      isLeave: json['is_leave'] ?? '',
      isActive: json['is_active'] ?? '',
      isAlumni: json['is_alumni'] ?? '',
      defaultLogin: json['default_login'] ?? '',
      updatedAt: json['updated_at'],
      parentId: json['parent_id'] ?? '',
      admissionNo: json['admission_no'] ?? '',
      admissionDate: json['admission_date'] ?? '',
      firstname: json['firstname'] ?? '',
      middlename: json['middlename'],
      lastname: json['lastname'] ?? '',
      rte: json['rte'] ?? '',
      image: json['image'] ?? '',
      mobileno: json['mobileno'] ?? '',
      email: json['email'] ?? '',
      state: json['state'],
      city: json['city'],
      pincode: json['pincode'],
      religion: json['religion'] ?? '',
      cast: json['cast'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      currentAddress: json['current_address'] ?? '',
      permanentAddress: json['permanent_address'] ?? '',
      categoryId: json['category_id'] ?? '',
      schoolHouseId: json['school_house_id'] ?? '',
      bloodGroup: json['blood_group'] ?? '',
      roomBedId: json['room_bed_id'] ?? '',
      adharNo: json['adhar_no'] ?? '',
      samagraId: json['samagra_id'] ?? '',
      bankAccountNo: json['bank_account_no'] ?? '',
      bankName: json['bank_name'] ?? '',
      ifscCode: json['ifsc_code'] ?? '',
      guardianIs: json['guardian_is'] ?? '',
      fatherName: json['father_name'] ?? '',
      fatherPhone: json['father_phone'] ?? '',
      fatherOccupation: json['father_occupation'] ?? '',
      motherName: json['mother_name'] ?? '',
      motherPhone: json['mother_phone'] ?? '',
      motherOccupation: json['mother_occupation'] ?? '',
      guardianName: json['guardian_name'] ?? '',
      guardianRelation: json['guardian_relation'] ?? '',
      guardianPhone: json['guardian_phone'] ?? '',
      guardianOccupation: json['guardian_occupation'] ?? '',
      guardianAddress: json['guardian_address'] ?? '',
      guardianEmail: json['guardian_email'] ?? '',
      fatherPic: json['father_pic'] ?? '',
      motherPic: json['mother_pic'] ?? '',
      guardianPic: json['guardian_pic'] ?? '',
      previousSchool: json['previous_school'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      measurementDate: json['measurement_date'] ?? '',
      disReason: json['dis_reason'] ?? '',
      note: json['note'] ?? '',
      disNote: json['dis_note'] ?? '',
      appKey: json['app_key'],
      parentAppKey: json['parent_app_key'],
      disableAt: json['disable_at'] ?? '',
      faceAuth: json['face_auth'] ?? '',
      esid: json['esid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    // You can generate this if needed.
    // Typically only needed when sending data back to server.
    return {};
  }
}


