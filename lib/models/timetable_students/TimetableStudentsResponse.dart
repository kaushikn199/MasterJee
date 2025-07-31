import 'package:masterjee/screens/timetable/time_table_students_screen.dart';

class TimetableStudentsResponse {
  final String status;
  final String message;
  final List<TimetableStudentsData> data;
  final bool result;

  TimetableStudentsResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory TimetableStudentsResponse.fromJson(Map<String, dynamic> json) {
    return TimetableStudentsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TimetableStudentsData.fromJson(e))
          .toList() ??
          [],
      result: json['result'] ?? false,
    );
  }
}

class TimetableStudentsData {
  final String id;
  final String sessionId;
  final String studentId;
  final String classId;
  final String sectionId;
  final String subjectGroupId;
  final String departmentId;
  final String programId;
  final String batchId;
  final String batchPeriodId;
  final String programPeriodCourseId;
  final String hostelRoomId;
  final String vehrouteId;
  final String routePickupPointId;
  final String transportFees;
  final String feesDiscount;
  final String isLeave;
  final String isActive;
  final String isAlumni;
  final String defaultLogin;
  final String createdAt;
  final String updatedAt;
  final String parentId;
  final String admissionNo;
  final String rollNo;
  final String admissionDate;
  final String firstname;
  final String middlename;
  final String lastname;
  final String rte;
  final String image;
  final String mobileno;
  final String email;
  final String state;
  final String city;
  final String pincode;
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
  final String appKey;
  final String parentAppKey;
  final String disableAt;
  final String faceAuth;
  final String ssid;
  String attendance;
   String selectedValueText;

  TimetableStudentsData({
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
    required this.attendance,
    required this.selectedValueText,
  });

  factory TimetableStudentsData.fromJson(Map<String, dynamic> json) {
    return TimetableStudentsData(
      id: json['id'] ?? '',
      sessionId: json['session_id'] ?? '',
      studentId: json['student_id'] ?? '',
      classId: json['class_id'] ?? '',
      sectionId: json['section_id'] ?? '',
      subjectGroupId: json['subject_group_id'] ?? '',
      departmentId: json['department_id'] ?? '',
      programId: json['program_id'] ?? '',
      batchId: json['batch_id'] ?? '',
      batchPeriodId: json['batch_period_id'] ?? '',
      programPeriodCourseId: json['program_period_course_id'] ?? '',
      hostelRoomId: json['hostel_room_id'] ?? '',
      vehrouteId: json['vehroute_id'] ?? '',
      routePickupPointId: json['route_pickup_point_id'] ?? '',
      transportFees: json['transport_fees'] ?? '0.00',
      feesDiscount: json['fees_discount'] ?? '0.00',
      isLeave: json['is_leave'] ?? '',
      isActive: json['is_active'] ?? '',
      isAlumni: json['is_alumni'] ?? '',
      defaultLogin: json['default_login'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      parentId: json['parent_id'] ?? '',
      admissionNo: json['admission_no'] ?? '',
      rollNo: json['roll_no'] ?? '',
      admissionDate: json['admission_date'] ?? '',
      firstname: json['firstname'] ?? '',
      middlename: json['middlename'] ?? '',
      lastname: json['lastname'] ?? '',
      rte: json['rte'] ?? '',
      image: json['image'] ?? '',
      mobileno: json['mobileno'] ?? '',
      email: json['email'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? '',
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
      appKey: json['app_key'] ?? '',
      parentAppKey: json['parent_app_key'] ?? '',
      disableAt: json['disable_at'] ?? '',
      faceAuth: json['face_auth'] ?? '',
      ssid: json['ssid'] ?? '',
      attendance: json['attendance'] ?? '',
      selectedValueText: json['selectedValueText'] ?? "Present",
    );
  }
}
