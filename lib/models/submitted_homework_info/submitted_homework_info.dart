class SubmittedHomeworkResponse {
  final String status;
  final String message;
  final List<SubmittedHomeworkData> data;
  final bool result;

  SubmittedHomeworkResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory SubmittedHomeworkResponse.fromJson(Map<String, dynamic> json) {
    return SubmittedHomeworkResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SubmittedHomeworkData.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class SubmittedHomeworkData {
  final String? id;
  final String? homeworkId;
  final String? studentId;
  final String? message;
  final String? docs;
  final String? fileName;
  final String? createdAt;
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
  final String? hostelRoomId;
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
  final String? isActive;
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
  final String? updatedAt;
  final String? faceAuth;
  final String? evlMarks;

  SubmittedHomeworkData({
    this.id,
    this.homeworkId,
    this.studentId,
    this.message,
    this.docs,
    this.fileName,
    this.createdAt,
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
    this.hostelRoomId,
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
    this.isActive,
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
    this.updatedAt,
    this.faceAuth,
    this.evlMarks,
  });

  factory SubmittedHomeworkData.fromJson(Map<String, dynamic> json) {
    return SubmittedHomeworkData(
      id: json['id'],
      homeworkId: json['homework_id'],
      studentId: json['student_id'],
      message: json['message'],
      docs: json['docs'],
      fileName: json['file_name'],
      createdAt: json['created_at'],
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
      hostelRoomId: json['hostel_room_id'],
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
      isActive: json['is_active'],
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
      updatedAt: json['updated_at'],
      faceAuth: json['face_auth'],
      evlMarks: json['evl_marks'],
    );
  }
}

