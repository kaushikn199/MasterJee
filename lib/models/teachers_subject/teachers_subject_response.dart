class SubjectResponse {
  final String status;
  final String message;
  final List<SubjectData> data;
  final bool result;

  SubjectResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SubjectData.fromJson(e))
          .toList() ??
          [],
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

class SubjectData {
  final String? id;
  final String? sessionId;
  final String? classId;
  final String? sectionId;
  final String? subjectGroupId;
  final String? subjectGroupSubjectId;
  final String? staffId;
  final String? day;
  final String? timeFrom;
  final String? timeTo;
  final String? startTime;
  final String? endTime;
  final String? roomNo;
  final String? createdAt;
  final String? subjectId;
  final String? name;
  final String? code;
  final String? type;
  final String? isActive;
  final String? linkedClass;
  final String? updatedAt;
  final String? className;
  final String? isHeduProgram;
  final String? isHeduProgramAlt;
  final String? section;
  final String? ttId;

  SubjectData({
    this.id,
    this.sessionId,
    this.classId,
    this.sectionId,
    this.subjectGroupId,
    this.subjectGroupSubjectId,
    this.staffId,
    this.day,
    this.timeFrom,
    this.timeTo,
    this.startTime,
    this.endTime,
    this.roomNo,
    this.createdAt,
    this.subjectId,
    this.name,
    this.code,
    this.type,
    this.isActive,
    this.linkedClass,
    this.updatedAt,
    this.className,
    this.isHeduProgram,
    this.isHeduProgramAlt,
    this.section,
    this.ttId,
  });

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      id: json['id'],
      sessionId: json['session_id'],
      classId: json['class_id'],
      sectionId: json['section_id'],
      subjectGroupId: json['subject_group_id'],
      subjectGroupSubjectId: json['subject_group_subject_id'],
      staffId: json['staff_id'],
      day: json['day'],
      timeFrom: json['time_from'],
      timeTo: json['time_to'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      roomNo: json['room_no'],
      createdAt: json['created_at'],
      subjectId: json['subject_id'],
      name: json['name'],
      code: json['code'],
      type: json['type'],
      isActive: json['is_active'],
      linkedClass: json['linked_class'],
      updatedAt: json['updated_at'],
      className: json['class'],
      isHeduProgram: json['is_hedu_program'],
      isHeduProgramAlt: json['ishedu_program'],
      section: json['section'],
      ttId: json['tt_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_id': sessionId,
      'class_id': classId,
      'section_id': sectionId,
      'subject_group_id': subjectGroupId,
      'subject_group_subject_id': subjectGroupSubjectId,
      'staff_id': staffId,
      'day': day,
      'time_from': timeFrom,
      'time_to': timeTo,
      'start_time': startTime,
      'end_time': endTime,
      'room_no': roomNo,
      'created_at': createdAt,
      'subject_id': subjectId,
      'name': name,
      'code': code,
      'type': type,
      'is_active': isActive,
      'linked_class': linkedClass,
      'updated_at': updatedAt,
      'class': className,
      'is_hedu_program': isHeduProgram,
      'ishedu_program': isHeduProgramAlt,
      'section': section,
      'tt_id': ttId,
    };
  }
}
