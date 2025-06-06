class PtmListResponse {
  final String status;
  final String message;
  final List<PTMData> data;
  final bool result;

  PtmListResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory PtmListResponse.fromJson(Map<String, dynamic> json) {
    return PtmListResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List).map((e) => PTMData.fromJson(e)).toList(),
      result: json['result'] ?? false,
    );
  }
}

class PTMData {
  final String ptmId;
  final String ptmTitle;
  final String fromDate;
  final String toDate;
  final String remark;
  final String hostBy;
  final List<Schedule> schedule;
  final List<Slot> slots;

  PTMData({
    required this.ptmId,
    required this.ptmTitle,
    required this.fromDate,
    required this.toDate,
    required this.remark,
    required this.hostBy,
    required this.schedule,
    required this.slots,
  });

  factory PTMData.fromJson(Map<String, dynamic> json) {
    return PTMData(
      ptmId: json['ptm_id']?.toString() ?? '',
      ptmTitle: json['ptm_title'] ?? '',
      fromDate: json['from_date'] ?? '',
      toDate: json['to_date'] ?? '',
      remark: json['remark'] ?? '',
      hostBy: json['host_by'] ?? '',
      schedule: (json['schedule'] as List)
          .map((e) => Schedule.fromJson(e))
          .toList(),
      slots: (json['slots'] as List).map((e) => Slot.fromJson(e)).toList(),
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
  final String gender;
  final String dob;
  final String image;
  final String mobileno;
  final String email;
  final String guardianName;
  final String guardianPhone;

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
    required this.gender,
    required this.dob,
    required this.image,
    required this.mobileno,
    required this.email,
    required this.guardianName,
    required this.guardianPhone,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      ptmsId: json['ptms_id']?.toString() ?? '',
      ptmId: json['ptm_id']?.toString() ?? '',
      studentId: json['student_id']?.toString() ?? '',
      parentId: json['parent_id']?.toString() ?? '',
      teacherId: json['teacher_id']?.toString() ?? '',
      date: json['date'] ?? '',
      timeFrom: json['time_from'] ?? '',
      timeTo: json['time_to'] ?? '',
      room: json['room'] ?? '',
      remark: json['remark'] ?? '',
      id: json['id']?.toString() ?? '',
      admissionNo: json['admission_no'] ?? '',
      rollNo: json['roll_no'] ?? '',
      admissionDate: json['admission_date'] ?? '',
      firstname: json['firstname'] ?? '',
      middlename: json['middlename'] ?? '',
      lastname: json['lastname'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      image: json['image'] ?? '',
      mobileno: json['mobileno'] ?? '',
      email: json['email'] ?? '',
      guardianName: json['guardian_name'] ?? '',
      guardianPhone: json['guardian_phone'] ?? '',
    );
  }
}

class Slot {
  final String ptsId;
  final String ptmId;
  final String timeFrom;
  final String timeTo;

  Slot({
    required this.ptsId,
    required this.ptmId,
    required this.timeFrom,
    required this.timeTo,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      ptsId: json['pts_id']?.toString() ?? '',
      ptmId: json['ptm_id']?.toString() ?? '',
      timeFrom: json['time_from'] ?? '',
      timeTo: json['time_to'] ?? '',
    );
  }
}
