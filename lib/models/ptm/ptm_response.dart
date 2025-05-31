class PtmResponse {
  final String status;
  final String message;
  final bool result;
  final List<PtmData> data;

  PtmResponse({
    required this.status,
    required this.message,
    required this.result,
    required this.data,
  });

  factory PtmResponse.fromJson(Map<String, dynamic> json) {
    return PtmResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => PtmData.fromJson(e))
          .toList(),
    );
  }
}

class PtmData {
  final String ptmId;
  final String ptmTitle;
  final String fromDate;
  final String toDate;
  final String remark;
  final String hostBy;
  final List<Schedule> schedule;

  PtmData({
    required this.ptmId,
    required this.ptmTitle,
    required this.fromDate,
    required this.toDate,
    required this.remark,
    required this.hostBy,
    required this.schedule,
  });

  factory PtmData.fromJson(Map<String, dynamic> json) {
    return PtmData(
      ptmId: json['ptm_id'] ?? '',
      ptmTitle: json['ptm_title'] ?? '',
      fromDate: json['from_date'] ?? '',
      toDate: json['to_date'] ?? '',
      remark: json['remark'] ?? '',
      hostBy: json['host_by'] ?? '',
      schedule: (json['schedule'] as List<dynamic>? ?? [])
          .map((e) => Schedule.fromJson(e))
          .toList(),
    );
  }
}

class Schedule {
  final String ptmsId;
  final String ptmId;
  final String studentId;
  final String parentId;
  final String teacherId;
  final String date;
  final String timeFrom;
  final String timeTo;
  final String room;
  final String remark;
  final String id;
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
  final String hostelRoomId;
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
  final String isActive;
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
  final String createdAt;
  final String updatedAt;
  final String faceAuth;

  Schedule({
    required this.ptmsId,
    required this.ptmId,
    required this.studentId,
    required this.parentId,
    required this.teacherId,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.room,
    required this.remark,
    required this.id,
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
    required this.hostelRoomId,
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
    required this.isActive,
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
    required this.createdAt,
    required this.updatedAt,
    required this.faceAuth,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      ptmsId: json['ptms_id'] ?? '',
      ptmId: json['ptm_id'] ?? '',
      studentId: json['student_id'] ?? '',
      parentId: json['parent_id'] ?? '',
      teacherId: json['teacher_id'] ?? '',
      date: json['date'] ?? '',
      timeFrom: json['time_from'] ?? '',
      timeTo: json['time_to'] ?? '',
      room: json['room'] ?? '',
      remark: json['remark'] ?? '',
      id: json['id'] ?? '',
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
      hostelRoomId: json['hostel_room_id'] ?? '',
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
      isActive: json['is_active'] ?? '',
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
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      faceAuth: json['face_auth'] ?? '',
    );
  }
}