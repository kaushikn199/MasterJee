import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverallResponseData {
  String? status;
  String? message;
  Data? data;
  bool? result;

  OverallResponseData({
    this.status,
    this.message,
    this.data,
    this.result,
  });

  factory OverallResponseData.fromJson(Map<String, dynamic> json) => OverallResponseData(
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
  List<Term>? terms;

  Data({
    this.terms,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    terms: json["terms"] == null ? [] : List<Term>.from(json["terms"]!.map((x) => Term.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "terms": terms == null ? [] : List<dynamic>.from(terms!.map((x) => x.toJson())),
  };
}

class Term {
  String? termName;
  List<Exam>? exams;
  List<Observation>? observations;

  Term({
    this.termName,
    this.exams,
    this.observations,
  });

  factory Term.fromJson(Map<String, dynamic> json) => Term(
    termName: json["term_name"],
    exams: json["exams"] == null ? [] : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),
    observations: json["observations"] == null ? [] : List<Observation>.from(json["observations"]!.map((x) => Observation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "term_name": termName,
    "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
    "observations": observations == null ? [] : List<dynamic>.from(observations!.map((x) => x.toJson())),
  };
}

class Exam {
  String? examName;
  List<Subject>? subjects;
  String? totalMarks;
  String? percentage;
  String? grade;
  String? rank;

  Exam({
    this.examName,
    this.subjects,
    this.totalMarks,
    this.percentage,
    this.grade,
    this.rank,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    examName: json["exam_name"],
    subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
    totalMarks: json["total_marks"],
    percentage: json["percentage"],
    grade: json["grade"],
    rank: json["rank"],
  );

  Map<String, dynamic> toJson() => {
    "exam_name": examName,
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
    "total_marks": totalMarks,
    "percentage": percentage,
    "grade": grade,
    "rank": rank,
  };
}

class Subject {
  String? subjectCode;
  String? subjectName;
  List<Assessment>? assessments;

  Subject({
    this.subjectCode,
    this.subjectName,
    this.assessments,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    subjectCode: json["subject_code"],
    subjectName: json["subject_name"],
    assessments: json["assessments"] == null ? [] : List<Assessment>.from(json["assessments"]!.map((x) => Assessment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subject_code": subjectCode,
    "subject_name": subjectName,
    "assessments": assessments == null ? [] : List<dynamic>.from(assessments!.map((x) => x.toJson())),
  };
}

class Assessment {
  String? assessmentName;
  String? obtainedMarks;
  String? maximumMarks;

  Assessment({
    this.assessmentName,
    this.obtainedMarks,
    this.maximumMarks,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
    assessmentName: json["assessment_name"],
    obtainedMarks: json["obtained_marks"],
    maximumMarks: json["maximum_marks"],
  );

  Map<String, dynamic> toJson() => {
    "assessment_name": assessmentName,
    "obtained_marks": obtainedMarks,
    "maximum_marks": maximumMarks,
  };
}

class Observation {
  String? parameterName;
  String? obtainMarks;
  String? maxMarks;

  Observation({
    this.parameterName,
    this.obtainMarks,
    this.maxMarks,
  });

  factory Observation.fromJson(Map<String, dynamic> json) => Observation(
    parameterName: json["parameter_name"],
    obtainMarks: json["obtain_marks"],
    maxMarks: json["max_marks"],
  );

  Map<String, dynamic> toJson() => {
    "parameter_name": parameterName,
    "obtain_marks": obtainMarks,
    "max_marks": maxMarks,
  };
}

