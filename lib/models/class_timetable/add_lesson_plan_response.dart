class AddLessonPlanResponse {
  final String status;
  final String message;
  final bool result;
  final TimetableData? data;

  AddLessonPlanResponse({
    required this.status,
    required this.message,
    required this.result,
    this.data,
  });

  factory AddLessonPlanResponse.fromJson(Map<String, dynamic> json) {
    return AddLessonPlanResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: json['data'] != null ? TimetableData.fromJson(json['data']) : null,
    );
  }
}

class TimetableData {
  final TtInfo? ttInfo;
  final List<Lesson> lessons;

  TimetableData({
    this.ttInfo,
    required this.lessons,
  });

  factory TimetableData.fromJson(Map<String, dynamic> json) {
    return TimetableData(
      ttInfo: json['ttInfo'] != null ? TtInfo.fromJson(json['ttInfo']) : null,
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class TtInfo {
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

  TtInfo({
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
  });

  factory TtInfo.fromJson(Map<String, dynamic> json) {
    return TtInfo(
      id: json['id'] ?? '',
      sessionId: json['session_id'] ?? '',
      classId: json['class_id'] ?? '',
      sectionId: json['section_id'] ?? '',
      subjectGroupId: json['subject_group_id'] ?? '',
      subjectGroupSubjectId: json['subject_group_subject_id'] ?? '',
      staffId: json['staff_id'] ?? '',
      day: json['day'] ?? '',
      timeFrom: json['time_from'] ?? '',
      timeTo: json['time_to'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      roomNo: json['room_no'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class Lesson {
  final String id;
  final String sessionId;
  final String subjectGroupSubjectId;
  final String subjectGroupClassSectionsId;
  final String name;
  final String createdAt;
  final List<Topic> topics;

  Lesson({
    required this.id,
    required this.sessionId,
    required this.subjectGroupSubjectId,
    required this.subjectGroupClassSectionsId,
    required this.name,
    required this.createdAt,
    required this.topics,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] ?? '',
      sessionId: json['session_id'] ?? '',
      subjectGroupSubjectId: json['subject_group_subject_id'] ?? '',
      subjectGroupClassSectionsId: json['subject_group_class_sections_id'] ?? '',
      name: json['name'] ?? '',
      createdAt: json['created_at'] ?? '',
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => Topic.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class Topic {
  final String id;
  final String sessionId;
  final String lessonId;
  final String name;
  final String status;
  final String? completeDate;
  final String createdAt;

  Topic({
    required this.id,
    required this.sessionId,
    required this.lessonId,
    required this.name,
    required this.status,
    this.completeDate,
    required this.createdAt,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] ?? '',
      sessionId: json['session_id'] ?? '',
      lessonId: json['lesson_id'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      completeDate: json['complete_date'],
      createdAt: json['created_at'] ?? '',
    );
  }
}
