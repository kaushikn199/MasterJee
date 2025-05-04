class HomeworkListResponse {
  final String status;
  final String message;
  final List<HomeworkData> data;
  final bool result;

  HomeworkListResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory HomeworkListResponse.fromJson(Map<String, dynamic> json) {
    return HomeworkListResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => HomeworkData.fromJson(e))
          .toList(),
      result: json['result'] ?? false,
    );
  }
}

class HomeworkData {
  final String? id;
  final String? classId;
  final String? sectionId;
  final String? sessionId;
  final String? staffId;
  final String? subjectGroupSubjectId;
  final String? subjectId;
  final String? homeworkDate;
  final String? submitDate;
  final String? marks;
  final String? description;
  final String? assignedToHouse;
  final String? assignedToPresident;
  final String? createDate;
  final String? evaluationDate;
  final String? document;
  final String? createdBy;
  final String? evaluatedBy;
  final String? createdAt;
  final String? subjectGroupId;
  final String? name;
  final String? code;
  final String? type;
  final String? isActive;
  final String? linkedClass;
  final String? updatedAt;
  final String? hwid;
  final String? sname;

  HomeworkData({
    this.id,
    this.classId,
    this.sectionId,
    this.sessionId,
    this.staffId,
    this.subjectGroupSubjectId,
    this.subjectId,
    this.homeworkDate,
    this.submitDate,
    this.marks,
    this.description,
    this.assignedToHouse,
    this.assignedToPresident,
    this.createDate,
    this.evaluationDate,
    this.document,
    this.createdBy,
    this.evaluatedBy,
    this.createdAt,
    this.subjectGroupId,
    this.name,
    this.code,
    this.type,
    this.isActive,
    this.linkedClass,
    this.updatedAt,
    this.hwid,
    this.sname,
  });

  factory HomeworkData.fromJson(Map<String, dynamic> json) {
    return HomeworkData(
      id: json['id'],
      classId: json['class_id'],
      sectionId: json['section_id'],
      sessionId: json['session_id'],
      staffId: json['staff_id'],
      subjectGroupSubjectId: json['subject_group_subject_id'],
      subjectId: json['subject_id'],
      homeworkDate: json['homework_date'],
      submitDate: json['submit_date'],
      marks: json['marks'],
      description: json['description'],
      assignedToHouse: json['assigned_to_house'],
      assignedToPresident: json['assigned_to_president'],
      createDate: json['create_date'],
      evaluationDate: json['evaluation_date'],
      document: json['document'],
      createdBy: json['created_by'],
      evaluatedBy: json['evaluated_by'],
      createdAt: json['created_at'],
      subjectGroupId: json['subject_group_id'],
      name: json['name'],
      code: json['code'],
      type: json['type'],
      isActive: json['is_active'],
      linkedClass: json['linked_class'],
      updatedAt: json['updated_at'],
      hwid: json['hwid'],
      sname: json['sname'],
    );
  }
}
