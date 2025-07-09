class ExamResponse {
  final String status;
  final String message;
  final bool result;
  final ExamData? data;

  ExamResponse({
    required this.status,
    required this.message,
    required this.result,
    this.data,
  });

  factory ExamResponse.fromJson(Map<String, dynamic> json) {
    return ExamResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      result: json['result'] ?? false,
      data: json['data'] != null ? ExamData.fromJson(json['data']) : null,
    );
  }
}

class ExamData {
  final List<Exam> exams;
  final List<Term> terms;
  final List<Assessment> assessments;
  final List<Grade> grades;

  ExamData({
    required this.exams,
    required this.terms,
    required this.assessments,
    required this.grades,
  });

  factory ExamData.fromJson(Map<String, dynamic> json) {
    return ExamData(
      exams: (json['exams'] as List?)?.map((e) => Exam.fromJson(e)).toList() ?? [],
      terms: (json['terms'] as List?)?.map((e) => Term.fromJson(e)).toList() ?? [],
      assessments: (json['assessments'] as List?)?.map((e) => Assessment.fromJson(e)).toList() ?? [],
      grades: (json['grades'] as List?)?.map((e) => Grade.fromJson(e)).toList() ?? [],
    );
  }
}


class Exam {
  final String id;
  final String? totalWorkingDays;
  final String? cbseTermId;
  final String? cbseTermGroupId;
  final String? cbseExamAssessmentId;
  final String? cbseExamGradeId;
  final String? name;
  final String? promoteClass;
  final String? examCode;
  final String? sessionId;
  final String? description;
  final String? combinedEw;
  final String? isPublish;
  final String? isActive;
  final String? createdBy;
  final String? useExamRollNo;
  final String? createdAt;
  final String? cbseExamId;
  final String? classSectionId;
  final String? classId;
  final String? sectionId;
  final String? updatedAt;
  final String? className;
  final String? isHeduProgram;
  final String? isheduProgram;
  final String? section;
  final String? termCode;
  final String? ceid;
  final String? ced;
  final String? ename;
  final String? cecsid;
  final String? csid;
  final String? cid;
  final String? sid;
  final String? tid;
  final String? tname;
  final String? aid;
  final String? aname;
  final String? gid;
  final String? gname;

  Exam({
    required this.id,
    this.totalWorkingDays,
    this.cbseTermId,
    this.cbseTermGroupId,
    this.cbseExamAssessmentId,
    this.cbseExamGradeId,
    this.name,
    this.promoteClass,
    this.examCode,
    this.sessionId,
    this.description,
    this.combinedEw,
    this.isPublish,
    this.isActive,
    this.createdBy,
    this.useExamRollNo,
    this.createdAt,
    this.cbseExamId,
    this.classSectionId,
    this.classId,
    this.sectionId,
    this.updatedAt,
    this.className,
    this.isHeduProgram,
    this.isheduProgram,
    this.section,
    this.termCode,
    this.ceid,
    this.ced,
    this.ename,
    this.cecsid,
    this.csid,
    this.cid,
    this.sid,
    this.tid,
    this.tname,
    this.aid,
    this.aname,
    this.gid,
    this.gname,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'] ?? '',
      totalWorkingDays: json['total_working_days'],
      cbseTermId: json['cbse_term_id'],
      cbseTermGroupId: json['cbse_term_group_id'],
      cbseExamAssessmentId: json['cbse_exam_assessment_id'],
      cbseExamGradeId: json['cbse_exam_grade_id'],
      name: json['name'],
      promoteClass: json['promote_class'],
      examCode: json['exam_code'],
      sessionId: json['session_id'],
      description: json['description'],
      combinedEw: json['combined_ew'],
      isPublish: json['is_publish'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      useExamRollNo: json['use_exam_roll_no'],
      createdAt: json['created_at'],
      cbseExamId: json['cbse_exam_id'],
      classSectionId: json['class_section_id'],
      classId: json['class_id'],
      sectionId: json['section_id'],
      updatedAt: json['updated_at'],
      className: json['class'],
      isHeduProgram: json['is_hedu_program'],
      isheduProgram: json['ishedu_program'],
      section: json['section'],
      termCode: json['term_code'],
      ceid: json['ceid'],
      ced: json['ced'],
      ename: json['ename'],
      cecsid: json['cecsid'],
      csid: json['csid'],
      cid: json['cid'],
      sid: json['sid'],
      tid: json['tid'],
      tname: json['tname'],
      aid: json['aid'],
      aname: json['aname'],
      gid: json['gid'],
      gname: json['gname'],
    );
  }
}


class Assessment {
  final String id;
  final String name;
  final String description;

  Assessment({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}


class Grade {
  final String id;
  final String name;
  final String description;
  final String? createdAt;

  Grade({
    required this.id,
    required this.name,
    required this.description,
    this.createdAt,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'],
    );
  }
}

class Term {
  final String id;
  final String name;
  final String termCode;
  final String description;
  final String createdBy;
  final String createdAt;

  Term({
    required this.id,
    required this.name,
    required this.termCode,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      termCode: json['term_code'] ?? '',
      description: json['description'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}