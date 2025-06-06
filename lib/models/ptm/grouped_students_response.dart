

class GroupedStudentsResponse {
  final String status;
  final String message;
  final bool result;
  final List<StudentData> data;

  GroupedStudentsResponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,
  });

  factory GroupedStudentsResponse.fromJson(Map<String, dynamic> json) {
    return GroupedStudentsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] != null && json['data'] is List)
          ? (json['data'] as List)
          .map((e) => StudentData.fromJson(e))
          .toList()
          : [],);
  }
}


class StudentData {
  final String id;
  final String sessionId;
  final String studentId;
  final String classId;
  final String sectionId;
  final String subjectGroupId;
  final String hostelRoomId;
  final String transportFees;
  final String feesDiscount;
  final String isLeave;
  final String isActive;
  final String isAlumni;
  final String defaultLogin;
  final String createdAt;
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
  final String dob;
  final String gender;
  final String guardianIs;
  final String fatherName;
  final String fatherPhone;
  final String guardianName;
  final String guardianRelation;
  final String guardianPhone;
  final String measurementDate;
  final String ssid;
  bool isChecked = false;

  StudentData({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.classId,
    required this.sectionId,
    required this.subjectGroupId,
    required this.hostelRoomId,
    required this.transportFees,
    required this.feesDiscount,
    required this.isLeave,
    required this.isActive,
    required this.isAlumni,
    required this.defaultLogin,
    required this.createdAt,
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
    required this.dob,
    required this.gender,
    required this.guardianIs,
    required this.fatherName,
    required this.fatherPhone,
    required this.guardianName,
    required this.guardianRelation,
    required this.guardianPhone,
    required this.measurementDate,
    required this.ssid,
    required this.isChecked,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json['id']?.toString() ?? '',
      sessionId: json['session_id']?.toString() ?? '',
      studentId: json['student_id']?.toString() ?? '',
      classId: json['class_id']?.toString() ?? '',
      sectionId: json['section_id']?.toString() ?? '',
      subjectGroupId: json['subject_group_id']?.toString() ?? '',
      hostelRoomId: json['hostel_room_id']?.toString() ?? '',
      transportFees: json['transport_fees']?.toString() ?? '',
      feesDiscount: json['fees_discount']?.toString() ?? '',
      isLeave: json['is_leave']?.toString() ?? '',
      isActive: json['is_active']?.toString() ?? '',
      isAlumni: json['is_alumni']?.toString() ?? '',
      defaultLogin: json['default_login']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      parentId: json['parent_id']?.toString() ?? '',
      admissionNo: json['admission_no']?.toString() ?? '',
      rollNo: json['roll_no']?.toString() ?? '',
      admissionDate: json['admission_date']?.toString() ?? '',
      firstname: json['firstname'] ?? '',
      middlename: json['middlename'] ?? '',
      lastname: json['lastname'] ?? '',
      rte: json['rte'] ?? '',
      image: json['image'] ?? '',
      mobileno: json['mobileno'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      guardianIs: json['guardian_is'] ?? '',
      fatherName: json['father_name'] ?? '',
      fatherPhone: json['father_phone'] ?? '',
      guardianName: json['guardian_name'] ?? '',
      guardianRelation: json['guardian_relation'] ?? '',
      guardianPhone: json['guardian_phone'] ?? '',
      measurementDate: json['measurement_date'] ?? '',
      ssid: json['ssid']?.toString() ?? '',
      isChecked: json['isChecked'] ?? false,
    );
  }
}
