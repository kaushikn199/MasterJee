class ClassTimetableResponse {
  ClassTimetableResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  final String status;
  final String message;
  final List<ClassTimetableData> data;
  final bool result;

  factory ClassTimetableResponse.fromJson(Map<String, dynamic> json){
    return ClassTimetableResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<ClassTimetableData>.from(json["data"]!.map((x) => ClassTimetableData.fromJson(x))),
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

class ClassTimetableData {
  ClassTimetableData({
    required this.day,
    required this.dayTimetable,
    this.ttData,
  });

  final String day;
  final List<DayTimetable> dayTimetable;
  final TtData? ttData;

  factory ClassTimetableData.fromJson(Map<String, dynamic> json){
    return ClassTimetableData(
      day: json["day"] ?? "",
      dayTimetable: json["day_timetable"] == null ? [] : List<DayTimetable>.from(json["day_timetable"]!.map((x) => DayTimetable.fromJson(x))),
      ttData: json["tt_data"] != null ? TtData.fromJson(json["tt_data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "day": day,
    "day_timetable": dayTimetable.map((x) => x.toJson()).toList(),
    if (ttData != null) "tt_data": ttData!.toJson(),
  };

}

class DayTimetable {
  DayTimetable({
    required this.timeFrom,
    required this.timeTo,
    required this.lessonPlans,
  });

  final String timeFrom;
  final String timeTo;
  final List<LessonPlan> lessonPlans;

  factory DayTimetable.fromJson(Map<String, dynamic> json){
    return DayTimetable(
      timeFrom: json["time_from"] ?? "",
      timeTo: json["time_to"] ?? "",
      lessonPlans: json["lesson_plans"] == null ? [] : List<LessonPlan>.from(json["lesson_plans"]!.map((x) => LessonPlan.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "time_from": timeFrom,
    "time_to": timeTo,
    "lesson_plans": lessonPlans.map((x) => x?.toJson()).toList(),
  };

}

class TtData {
  TtData({
    required this.id,
    required this.sessionId,
    required this.classId,
    required this.sectionId,
    required this.subjectGroupId,
    required this.subjectGroupSubjectId,
    required this.staffId,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    required this.startTime,
    required this.endTime,
    required this.roomNo,
    required this.createdAt,
    required this.ttId,
  });

  final String id;
  final String sessionId;
  final String classId;
  final String sectionId;
  final String subjectGroupId;
  final String subjectGroupSubjectId;
  final String staffId;
  final String day;
  final String timeFrom;
  final String timeTo;
  final String startTime;
  final String endTime;
  final String roomNo;
  final String createdAt;
  final String ttId;

  factory TtData.fromJson(Map<String, dynamic> json) {
    return TtData(
      id: json["id"] ?? "",
      sessionId: json["session_id"] ?? "",
      classId: json["class_id"] ?? "",
      sectionId: json["section_id"] ?? "",
      subjectGroupId: json["subject_group_id"] ?? "",
      subjectGroupSubjectId: json["subject_group_subject_id"] ?? "",
      staffId: json["staff_id"] ?? "",
      day: json["day"] ?? "",
      timeFrom: json["time_from"] ?? "",
      timeTo: json["time_to"] ?? "",
      startTime: json["start_time"] ?? "",
      endTime: json["end_time"] ?? "",
      roomNo: json["room_no"] ?? "",
      createdAt: json["created_at"] ?? "",
      ttId: json["tt_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "session_id": sessionId,
    "class_id": classId,
    "section_id": sectionId,
    "subject_group_id": subjectGroupId,
    "subject_group_subject_id": subjectGroupSubjectId,
    "staff_id": staffId,
    "day": day,
    "time_from": timeFrom,
    "time_to": timeTo,
    "start_time": startTime,
    "end_time": endTime,
    "room_no": roomNo,
    "created_at": createdAt,
    "tt_id": ttId,
  };
}

class LessonPlan {
  LessonPlan({
    required this.name,
    required this.lessonPlanClass,
    required this.section,
  });

  final String name;
  final String lessonPlanClass;
  final String section;

  factory LessonPlan.fromJson(Map<String, dynamic> json){
    return LessonPlan(
      name: json["name"] ?? "",
      lessonPlanClass: json["class"] ?? "",
      section: json["section"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "class": lessonPlanClass,
    "section": section,
  };

}
