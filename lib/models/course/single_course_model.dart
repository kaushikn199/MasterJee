class SingleCourseModule {
  String? status;
  String? message;
  Data? data;
  bool? result;

  SingleCourseModule({
    this.status,
    this.message,
    this.data,
    this.result,
  });

  factory SingleCourseModule.fromJson(Map<String, dynamic> json) => SingleCourseModule(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "result": result,
  };
}

class Data {
  String? courseId;
  String? title;
  Teacher? teacher;
  String? dataClass;
  List<Section>? sections;

  Data({
    this.courseId,
    this.title,
    this.teacher,
    this.dataClass,
    this.sections,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    courseId: json["course_id"],
    title: json["title"],
    teacher: json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]),
    dataClass: json["class"],
    sections: json["sections"] == null ? [] : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "course_id": courseId,
    "title": title,
    "teacher": teacher?.toJson(),
    "class": dataClass,
    "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}

class Section {
  String? sectionId;
  String? sectionTitle;
  List<Lesson>? lessons;

  Section({
    this.sectionId,
    this.sectionTitle,
    this.lessons,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    sectionId: json["section_id"],
    sectionTitle: json["section_title"],
    lessons: json["lessons"] == null ? [] : List<Lesson>.from(json["lessons"]!.map((x) => Lesson.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "section_id": sectionId,
    "section_title": sectionTitle,
    "lessons": lessons == null ? [] : List<dynamic>.from(lessons!.map((x) => x.toJson())),
  };
}

class Lesson {
  String? lessonId;
  String? lessonTitle;
  String? lessonType;
  String? videoUrl;
  String? downloadUrl;
  String? summary;

  Lesson({
    this.lessonId,
    this.lessonTitle,
    this.lessonType,
    this.videoUrl,
    this.downloadUrl,
    this.summary,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    lessonId: json["lesson_id"],
    lessonTitle: json["lesson_title"],
    lessonType: json["lesson_type"],
    videoUrl: json["video_url"],
    downloadUrl: json["download_url"],
    summary: json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "lesson_id": lessonId,
    "lesson_title": lessonTitle,
    "lesson_type": lessonType,
    "video_url": videoUrl,
    "download_url": downloadUrl,
    "summary": summary,
  };
}

class Teacher {
  String? employeeId;
  String? name;

  Teacher({
    this.employeeId,
    this.name,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    employeeId: json["employee_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "name": name,
  };
}
