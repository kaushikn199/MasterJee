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
  });

  final String day;
  final List<DayTimetable> dayTimetable;

  factory ClassTimetableData.fromJson(Map<String, dynamic> json){
    return ClassTimetableData(
      day: json["day"] ?? "",
      dayTimetable: json["day_timetable"] == null ? [] : List<DayTimetable>.from(json["day_timetable"]!.map((x) => DayTimetable.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "day": day,
    "day_timetable": dayTimetable.map((x) => x.toJson()).toList(),
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
