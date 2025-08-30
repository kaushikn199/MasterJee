class GetCourseReportModel {
  String? status;
  String? message;
  Data? data;
  bool? result;

  GetCourseReportModel({this.status, this.message, this.data, this.result});

  factory GetCourseReportModel.fromJson(Map<String, dynamic> json) =>
      GetCourseReportModel(
        status: json['status'],
        message: json['message'],
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
        result: json['result'],
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    if (data != null) 'data': data!.toJson(),
    'result': result,
  };
}

class Data {
  List<Rating>? rating;
  List<Sell>? sell;

  Data({this.rating, this.sell});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    rating: json['rating'] != null
        ? (json['rating'] as List).map((v) => Rating.fromJson(v)).toList()
        : [],
    sell: json['sell'] != null
        ? (json['sell'] as List).map((v) => Sell.fromJson(v)).toList()
        : [],
  );

  Map<String, dynamic> toJson() => {
    if (rating != null) 'rating': rating!.map((v) => v.toJson()).toList(),
    if (sell != null) 'sell': sell!.map((v) => v.toJson()).toList(),
  };
}

class Rating {
  String? id;
  String? studentId;
  String? courseId;
  String? rating;
  String? review;
  String? courseName;
  String? className;
  String? paidAmount;

  String? view;

  Rating({this.id, this.studentId,this.paidAmount,  this.view,this.courseId, this.rating, this.review, this.courseName,this.className});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json['id'],
    studentId: json['student_id'],
    courseId: json['course_id'],
    rating: json['rating'],
    review: json['review'],
    className: json['classname'],
    courseName: json['title'],
    view: json['view_count'],
    paidAmount: json['price'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'student_id': studentId,
    'price': paidAmount,
    'course_id': courseId,
    'rating': rating,
    'review': review,
    'title': courseName,
    'classname': className,
    'view_count': view,
  };
}

class Sell {
  String? id;
  String? courseName;
  String? studentId;
  String? studentName;
  String? actualPrice;
  String? paidAmount;
  String? view;
  String? className;
  String? date;

  Sell({this.id, this.courseName, this.actualPrice,this.studentId, this.studentName, this.paidAmount, this.className,this.view,this.date});

  factory Sell.fromJson(Map<String, dynamic> json) => Sell(
    id: json['id'],
    courseName: json['title'],
    actualPrice: json['actual_price'],
    paidAmount: json['paid_amount'],
    className: json['course_name'],
    view: json['view_count'],
    studentId: json["student_id"],
    date: json["date"],
    studentName: json["firstname"],  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'course_name': courseName,
    'actual_price': actualPrice,
    'paid_amount': paidAmount,
    'classname': className,
    'view_count': view,
    "student_id": studentId,
    "firstname": studentName,
    "date": date,
  };
}

class CompleteReportResponse {
  String? status;
  String? message;
  List<CompleteReport>? data;
  bool? result;

  CompleteReportResponse({
    this.status,
    this.message,
    this.data,
    this.result,
  });

  factory CompleteReportResponse.fromJson(Map<String, dynamic> json) => CompleteReportResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CompleteReport>.from(json["data"]!.map((x) => CompleteReport.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "result": result,
  };
}

class CompleteReport {
  String? studentId;
  String? admissionNo;
  String? studentName;
  dynamic courseId;
  dynamic courseTitle;
  int? progress;

  CompleteReport({
    this.studentId,
    this.admissionNo,
    this.studentName,
    this.courseId,
    this.courseTitle,
    this.progress,
  });

  factory CompleteReport.fromJson(Map<String, dynamic> json) => CompleteReport(
    studentId: json["student_id"],
    admissionNo: json["admission_no"],
    studentName: json["student_name"],
    courseId: json["course_id"],
    courseTitle: json["course_title"],
    progress: json["progress"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "admission_no": admissionNo,
    "student_name": studentName,
    "course_id": courseId,
    "course_title": courseTitle,
    "progress": progress,
  };
}
