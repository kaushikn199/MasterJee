class LoginData {
  LoginData({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  final String status;
  final String message;
  final UserData? data;
  final bool result;

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      result: json['result'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
    'result': result,
  };
}

class UserData {
  final String? userid;
  final String? userId;
  final String? staffId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? email;
  final String? classId;
  final String? sectionId;
  final String? pushToken;
  final bool? isLoggedIn;
  final bool? isSectionIn;
  final bool? isLibrn;
  final bool? isRcptn;
  final bool? isTechr;
  final bool? isClInc;
  final bool? isCoord;
  final bool? isAdmin;
  final String? sessionId;
  final String? userImage; // ✅ Added this

  UserData({
    this.userid,
    this.userId,
    this.staffId,
    this.username,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.classId,
    this.sectionId,
    this.pushToken,
    this.isLoggedIn,
    this.isSectionIn,
    this.isLibrn,
    this.isRcptn,
    this.isTechr,
    this.isClInc,
    this.isCoord,
    this.isAdmin,
    this.sessionId,
    this.userImage,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userid: json['userid'],
      userId: json['user_id'],
      staffId: json['staff_id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobile: json['mobile'],
      email: json['email'],
      classId: json['class_id'],
      sectionId: json['section_id'],
      pushToken: json['push_token'],
      isLoggedIn: json['isLoggedIn'],
      isSectionIn: json['isSectionIn'],
      isLibrn: json['isLibrn'],
      isRcptn: json['isRcptn'],
      isTechr: json['isTechr'],
      isClInc: json['isClInc'],
      isCoord: json['isCoord'],
      isAdmin: json['isAdmin'],
      sessionId: json['sessionId'],
      userImage: json['userImage'], // ✅ Added this
    );
  }

  Map<String, dynamic> toJson() => {
    'userid': userid,
    'user_id': userId,
    'staff_id': staffId,
    'username': username,
    'first_name': firstName,
    'last_name': lastName,
    'mobile': mobile,
    'email': email,
    'class_id': classId,
    'section_id': sectionId,
    'push_token': pushToken,
    'isLoggedIn': isLoggedIn,
    'isSectionIn': isSectionIn,
    'isLibrn': isLibrn,
    'isRcptn': isRcptn,
    'isTechr': isTechr,
    'isClInc': isClInc,
    'isCoord': isCoord,
    'isAdmin': isAdmin,
    'sessionId': sessionId,
    'userImage': userImage,
  };
}