class ClassSectionResponse {
  ClassSectionResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  final String status;
  final String message;
  final List<ClassData> data;
  final bool result;

  factory ClassSectionResponse.fromJson(Map<String, dynamic> json){
    return ClassSectionResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<ClassData>.from(json["data"]!.map((x) => ClassData.fromJson(x))),
      result: json["result"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.map((x) => x.toJson()).toList(),
    "result": result,
  };

}

class ClassData {
  ClassData({
    required this.ccId,
    required this.staffId,
    required this.classId,
    required this.id,
    required this.className,
    required this.isHeduProgram,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.isheduProgram,
    required this.sections,
    required this.sessionId,
    required this.sectionId,
    required this.subjectGroupId,
    required this.subjectGroupSubjectId,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    required this.startTime,
    required this.endTime,
    required this.roomNo,
  });

  final String ccId;
  final String staffId;
  final String classId;
  final String id;
  final String className;
  final String isHeduProgram;
  final String isActive;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final dynamic isheduProgram;
  final List<SectionData> sections;
  final String sessionId;
  final String sectionId;
  final String subjectGroupId;
  final String subjectGroupSubjectId;
  final String day;
  final String timeFrom;
  final String timeTo;
  final String startTime;
  final String endTime;
  final String roomNo;

  factory ClassData.fromJson(Map<String, dynamic> json){
    return ClassData(
      ccId: json["cc_id"] ?? "",
      staffId: json["staff_id"] ?? "",
      classId: json["class_id"] ?? "",
      id: json["id"] ?? "",
      className: json["class"] ?? "",
      isHeduProgram: json["is_hedu_program"] ?? "",
      isActive: json["is_active"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: json["updated_at"],
      isheduProgram: json["ishedu_program"],
      sections: json["sections"] == null ? [] : List<SectionData>.from(json["sections"]!.map((x) => SectionData.fromJson(x))),
      sessionId: json["session_id"] ?? "",
      sectionId: json["section_id"] ?? "",
      subjectGroupId: json["subject_group_id"] ?? "",
      subjectGroupSubjectId: json["subject_group_subject_id"] ?? "",
      day: json["day"] ?? "",
      timeFrom: json["time_from"] ?? "",
      timeTo: json["time_to"] ?? "",
      startTime: json["start_time"] ?? "",
      endTime: json["end_time"] ?? "",
      roomNo: json["room_no"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "cc_id": ccId,
    "staff_id": staffId,
    "class_id": classId,
    "id": id,
    "class": className,
    "is_hedu_program": isHeduProgram,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "ishedu_program": isheduProgram,
    "sections": sections.map((x) => x?.toJson()).toList(),
    "session_id": sessionId,
    "section_id": sectionId,
    "subject_group_id": subjectGroupId,
    "subject_group_subject_id": subjectGroupSubjectId,
    "day": day,
    "time_from": timeFrom,
    "time_to": timeTo,
    "start_time": startTime,
    "end_time": endTime,
    "room_no": roomNo,
  };

}

class SectionData {
  SectionData({
    required this.id,
    required this.section,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.classId,
    required this.sectionId,
  });

  final String id;
  final String section;
  final String isActive;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final String classId;
  final String sectionId;

  factory SectionData.fromJson(Map<String, dynamic> json){
    return SectionData(
      id: json["id"] ?? "",
      section: json["section"] ?? "",
      isActive: json["is_active"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: json["updated_at"],
      classId: json["class_id"] ?? "",
      sectionId: json["section_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "section": section,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "class_id": classId,
    "section_id": sectionId,
  };

}
