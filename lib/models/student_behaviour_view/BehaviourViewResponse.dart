class BehaviourViewResponse {
  final String status;
  final String message;
  final StudentDataWrapper? data;
  final bool result;

  BehaviourViewResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory BehaviourViewResponse.fromJson(Map<String, dynamic> json) {
    return BehaviourViewResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      data: json['data'] != null
          ? StudentDataWrapper.fromJson(json['data'])
          : null, // Provide a default
      result: json['result'] ?? false,
    );
  }

}

class StudentDataWrapper {
  final Student studentData;
  final List<IncidentData> incidentData;

  StudentDataWrapper({
    required this.studentData,
    required this.incidentData,
  });

  factory StudentDataWrapper.fromJson(Map<String, dynamic> json) {
    return StudentDataWrapper(
      studentData: Student.fromJson(json['student_data']),
      incidentData: (json['incident_data'] as List)
          .map((e) => IncidentData.fromJson(e))
          .toList(),
    );
  }

}


class Student {
  final String id;
  final String admissionNo;
  final String rollNo;
  final String firstname;
  final String? middlename;
  final String lastname;
  final String rte;
  final String image;
  final String? email;
  final String? dob;
  final String gender;
  final String bloodGroup;
  final String height;
  final String weight;
  final String disableAt;
  final String faceAuth;

  Student({
    required this.id,
    required this.admissionNo,
    required this.rollNo,
    required this.firstname,
    this.middlename,
    required this.lastname,
    required this.rte,
    required this.image,
    this.email,
    this.dob,
    required this.gender,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.disableAt,
    required this.faceAuth,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id']  ?? "",
      admissionNo: json['admission_no']  ?? "",
      rollNo: json['roll_no']  ?? "",
      firstname: json['firstname']  ?? "",
      middlename: json['middlename']  ?? "",
      lastname: json['lastname']  ?? "",
      rte: json['rte']  ?? "",
      image: json['image']  ?? "",
      email: json['email']  ?? "",
      dob: json['dob']  ?? "",
      gender: json['gender']  ?? "",
      bloodGroup: json['blood_group']  ?? "",
      height: json['height']  ?? "",
      weight: json['weight']  ?? "",
      disableAt: json['disable_at']  ?? "",
      faceAuth: json['face_auth']  ?? "",
    );
  }
}

class IncidentData {
  final String incidentId;
  final String title;
  final String description;
  final String point;
  final String createdAt;
  final String idate;
  final String name;
  final String employeeId;
  final String studentId;
  final List<StudentComment> studentComments;
  final List<StudentComment> staffComments;

  IncidentData({
    required this.incidentId,
    required this.title,
    required this.description,
    required this.point,
    required this.createdAt,
    required this.studentComments,
    required this.staffComments,
    required this.idate,
    required this.name,
    required this.employeeId,
    required this.studentId,
  });

  factory IncidentData.fromJson(Map<String, dynamic> json) {
    return IncidentData(
      incidentId: json['incident_id']  ?? "",
      title: json['title']  ?? "",
      description: json['description']  ?? "",
      point: json['point']  ?? "",
      createdAt: json['created_at']  ?? "",
      idate: json['idate']  ?? "",
      name: json['name']  ?? "",
      employeeId: json['employee_id']  ?? "",
      studentId: json['student_id']  ?? "",
      studentComments: (json['studentComments'] as List).map((e) => StudentComment.fromJson(e)).toList(),
      staffComments: (json['staffComments'] as List).map((e) => StudentComment.fromJson(e)).toList(),
      /*json['staffComments'] ?? []*/
    );
  }
}

class StudentComment {
  final String id;
  final String comment;
  final String type;
  final String createdDate;

  StudentComment({
    required this.id,
    required this.comment,
    required this.type,
    required this.createdDate,
  });

  factory StudentComment.fromJson(Map<String, dynamic> json) {
    return StudentComment(
      id: json['id']  ?? "",
      comment: json['comment']  ?? "",
      type: json['type'],
      createdDate: json['created_date']  ?? "",
    );
  }
}


