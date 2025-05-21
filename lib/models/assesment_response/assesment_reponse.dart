class AssesmentResponse{
  final String status;
  final String message;
  final Data data;
  final bool result;

AssesmentResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory AssesmentResponse.fromJson(Map<String, dynamic> json) {
    return AssesmentResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: Data.fromJson(json['data']),
      result: json['result'] ?? false,
    );
  }
}

class Data {
  final List<Student> students;
  final List<ExamType> examType;
  final List<Subject> subjects;

  Data({
    required this.students,
    required this.examType,
    required this.subjects,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      students: (json['students'] as List)
          .map((e) => Student.fromJson(e))
          .toList(),
      examType: (json['examType'] as List)
          .map((e) => ExamType.fromJson(e))
          .toList(),
      subjects: (json['subjects'] as List)
          .map((e) => Subject.fromJson(e))
          .toList(),
    );
  }
}

class Student {
  final String id;
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
  bool isChecked;

  Student({
    required this.id,
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
    this.isChecked = false,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
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
      isChecked: json['isChecked'] ?? false,
    );
  }
}

class ExamType {
  final String id;
  final String? exam;
  final String? passingPercentage;
  final String? sessionId;
  final String? dateFrom;
  final String? dateTo;
  final String? examGroupId;
  final String? useExamRollNo;
  final String? isPublish;
  final String? isRankGenerated;
  final String? description;
  final String? isActive;
  final String? createdAt;
  final String? updatedAt;

  ExamType({
    required this.id,
    this.exam,
    this.passingPercentage,
    this.sessionId,
    this.dateFrom,
    this.dateTo,
    this.examGroupId,
    this.useExamRollNo,
    this.isPublish,
    this.isRankGenerated,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ExamType.fromJson(Map<String, dynamic> json) {
    return ExamType(
      id: json['id'] ?? '',
      exam: json['exam'],
      passingPercentage: json['passing_percentage'],
      sessionId: json['session_id'],
      dateFrom: json['date_from'],
      dateTo: json['date_to'],
      examGroupId: json['exam_group_id'],
      useExamRollNo: json['use_exam_roll_no'],
      isPublish: json['is_publish'],
      isRankGenerated: json['is_rank_generated'],
      description: json['description'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Subject {
  final String id;
  final String? name;
  final String? code;
  final String? type;
  final String? isActive;
  final String? linkedClass;
  final String? createdAt;
  final String? updatedAt;

  Subject({
    required this.id,
    this.name,
    this.code,
    this.type,
    this.isActive,
    this.linkedClass,
    this.createdAt,
    this.updatedAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] ?? '',
      name: json['name'],
      code: json['code'],
      type: json['type'],
      isActive: json['is_active'],
      linkedClass: json['linked_class'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
