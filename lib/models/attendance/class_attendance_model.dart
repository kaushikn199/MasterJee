class Day {
  String? subjectId;
  String? subjectName;
  String? code;
  String? type;
  String? name;
  String? surname;
  String? employeeId;
  String? id;
  String? sessionId;
  String? classId;
  String? sectionId;
  String? subjectGroupId;
  String? subjectGroupSubjectId;
  String? staffId;
  String? day;
  String? timeFrom;
  String? timeTo;
  String? startTime;
  String? endTime;
  String? roomNo;
  DateTime? createdAt;
  String? subjectGroupClassSectionsId;

  Day({
    this.subjectId,
    this.subjectName,
    this.code,
    this.type,
    this.name,
    this.surname,
    this.employeeId,
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
    this.subjectGroupClassSectionsId,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    subjectId: json["subject_id"],
    subjectName: json["subject_name"],
    code: json["code"],
    type: json["type"],
    name: json["name"],
    surname: json["surname"],
    employeeId: json["employee_id"],
    id: json["id"],
    sessionId: json["session_id"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    subjectGroupId: json["subject_group_id"],
    subjectGroupSubjectId: json["subject_group_subject_id"],
    staffId: json["staff_id"],
    day: json["day"],
    timeFrom: json["time_from"],
    timeTo: json["time_to"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    roomNo: json["room_no"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    subjectGroupClassSectionsId: json["subject_group_class_sections_id"],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "subject_name": subjectName,
    "code": code,
    "type": type,
    "name": name,
    "surname": surname,
    "employee_id": employeeId,
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
    "created_at": createdAt?.toIso8601String(),
    "subject_group_class_sections_id": subjectGroupClassSectionsId,
  };
}

class ScheduleResponse {
  Timetable? timetable;
  String? status;

  ScheduleResponse({
    this.timetable,
    this.status,
  });

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) => ScheduleResponse(
    timetable: json["timetable"] == null ? null : Timetable.fromJson(json["timetable"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "timetable": timetable?.toJson(),
    "status": status,
  };
}

class Timetable {
  List<Day>? monday;
  List<Day>? tuesday;
  List<Day>? wednesday;
  List<Day>? thursday;
  List<Day>? friday;
  List<Day>? saturday;
  List<Day>? sunday;

  Timetable({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
    monday: json["Monday"] == null
        ? []
        : List<Day>.from(json["Monday"]!.map((x) => Day.fromJson(x))),
    tuesday: json["Tuesday"] == null
        ? []
        : List<Day>.from(json["Tuesday"]!.map((x) => Day.fromJson(x))),
    wednesday: json["Wednesday"] == null
        ? []
        : List<Day>.from(json["Wednesday"]!.map((x) => Day.fromJson(x))),
    thursday: json["Thursday"] == null
        ? []
        : List<Day>.from(json["Thursday"]!.map((x) => Day.fromJson(x))),
    friday: json["Friday"] == null
        ? []
        : List<Day>.from(json["Friday"]!.map((x) => Day.fromJson(x))),
    saturday: json["Saturday"] == null
        ? []
        : List<Day>.from(json["Saturday"]!.map((x) => Day.fromJson(x))),
    sunday: json["Sunday"] == null
        ? []
        : List<Day>.from(json["Sunday"]!.map((x) => Day.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Monday": monday == null ? [] : List<dynamic>.from(monday!.map((x) => x.toJson())),
    "Tuesday": tuesday == null ? [] : List<dynamic>.from(tuesday!.map((x) => x.toJson())),
    "Wednesday": wednesday == null ? [] : List<dynamic>.from(wednesday!.map((x) => x.toJson())),
    "Thursday": thursday == null ? [] : List<dynamic>.from(thursday!.map((x) => x)),
    "Friday": friday == null ? [] : List<dynamic>.from(friday!.map((x) => x.toJson())),
    "Saturday": saturday == null ? [] : List<dynamic>.from(saturday!.map((x) => x.toJson())),
    "Sunday": sunday == null ? [] : List<dynamic>.from(sunday!.map((x) => x.toJson())),
  };
}