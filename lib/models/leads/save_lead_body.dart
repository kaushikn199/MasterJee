class SaveLeadBody {
  String userId;
  String lId;
  String cId;
  String lName;
  String lDob;
  String lCaste;
  String lSubCaste;
  String lBloodGroup;
  String lReligion;
  String lMotherTongue;
  String lFatherName;
  String lFatherPhone;
  String lFatherQualification;
  String lMotherName;
  String lMotherPhone;
  String lMotherQualification;
  String lGuradianName;
  String lGuardianPhone;
  String lClass;
  String lEnrolledCourse;
  String lElectiveSubjects;
  String lAddress;
  String lLocation;
  String lPhoneNumber;
  String lAlternativePhone;
  String lEmergencyContactNo;
  String lEmail;
  String lSource;
  String lResources;
  String lat;
  String lng;
  String lGender;
  String lAadharNo;//33

  SaveLeadBody({
    this.userId = "",
    this.lId = "",
    this.cId = "",
    this.lName = "",
    this.lDob = "",
    this.lCaste = "",
    this.lSubCaste = "",
    this.lBloodGroup = "",
    this.lReligion = "",
    this.lMotherTongue = "",
    this.lFatherName = "",
    this.lFatherPhone = "",
    this.lFatherQualification = "",
    this.lMotherName = "",
    this.lMotherPhone = "",
    this.lMotherQualification = "",
    this.lGuradianName = "",
    this.lGuardianPhone = "",
    this.lClass = "",
    this.lEnrolledCourse = "",
    this.lElectiveSubjects = "",
    this.lAddress = "",
    this.lLocation = "",
    this.lPhoneNumber = "",
    this.lAlternativePhone = "",
    this.lEmergencyContactNo = "",
    this.lEmail = "",
    this.lSource = "",
    this.lResources = "",
    this.lat = "",
    this.lng = "",
    this.lGender = "",
    this.lAadharNo = "",
  });

  factory SaveLeadBody.fromJson(Map<String, dynamic> json) {
    return SaveLeadBody(
      userId: json['userId'] ?? "",
      lId: json['lId'] ?? "",
      cId: json['cId'] ?? "",
      lName: json['lName'] ?? "",
      lDob: json['lDob'] ?? "",
      lCaste: json['lCaste'] ?? "",
      lSubCaste: json['lSubCaste'] ?? "",
      lBloodGroup: json['lBloodGroup'] ?? "",
      lReligion: json['lReligion'] ?? "",
      lMotherTongue: json['lMotherTongue'] ?? "",
      lFatherName: json['lFatherName'] ?? "",
      lFatherPhone: json['lFatherPhone'] ?? "",
      lFatherQualification: json['lFatherQualification'] ?? "",
      lMotherName: json['lMotherName'] ?? "",
      lMotherPhone: json['lMotherPhone'] ?? "",
      lMotherQualification: json['lMotherQualification'] ?? "",
      lGuradianName: json['lGuradianName'] ?? "",
      lGuardianPhone: json['lGuardianPhone'] ?? "",
      lClass: json['lClass'] ?? "",
      lEnrolledCourse: json['lEnrolledCourse'] ?? "",
      lElectiveSubjects: json['lElectiveSubjects'] ?? "",
      lAddress: json['lAddress'] ?? "",
      lLocation: json['lLocation'] ?? "",
      lPhoneNumber: json['lPhoneNumber'] ?? "",
      lAlternativePhone: json['lAlternativePhone'] ?? "",
      lEmergencyContactNo: json['lEmergencyContactNo'] ?? "",
      lEmail: json['lEmail'] ?? "",
      lSource: json['lSource'] ?? "",
      lResources: json['lResources'] ?? "",
      lat: json['lat'] ?? "",
      lng: json['lng'] ?? "",
      lGender: json['lGender'] ?? "",
      lAadharNo: json['lAadharNo'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'lId': lId,
      'cId': cId,
      'lName': lName,
      'lDob': lDob,
      'lCaste': lCaste,
      'lSubCaste': lSubCaste,
      'lBloodGroup': lBloodGroup,
      'lReligion': lReligion,
      'lMotherTongue': lMotherTongue,
      'lFatherName': lFatherName,
      'lFatherPhone': lFatherPhone,
      'lFatherQualification': lFatherQualification,
      'lMotherName': lMotherName,
      'lMotherPhone': lMotherPhone,
      'lMotherQualification': lMotherQualification,
      'lGuradianName': lGuradianName,
      'lGuardianPhone': lGuardianPhone,
      'lClass': lClass,
      'lEnrolledCourse': lEnrolledCourse,
      'lElectiveSubjects': lElectiveSubjects,
      'lAddress': lAddress,
      'lLocation': lLocation,
      'lPhoneNumber': lPhoneNumber,
      'lAlternativePhone': lAlternativePhone,
      'lEmergencyContactNo': lEmergencyContactNo,
      'lEmail': lEmail,
      'lSource': lSource,
      'lResources': lResources,
      'lat': lat,
      'lng': lng,
      'lGender': lGender,
      'lAadharNo': lAadharNo,
    };
  }

  @override
  String toString() {
    return '''
SaveLeadBody(
  userId: $userId,
  lId: $lId,
  cId: $cId,
  lName: $lName,
  lDob: $lDob,
  lCaste: $lCaste,
  lSubCaste: $lSubCaste,
  lBloodGroup: $lBloodGroup,
  lReligion: $lReligion,
  lMotherTongue: $lMotherTongue,
  lFatherName: $lFatherName,
  lFatherPhone: $lFatherPhone,
  lFatherQualification: $lFatherQualification,
  lMotherName: $lMotherName,
  lMotherPhone: $lMotherPhone,
  lMotherQualification: $lMotherQualification,
  lGuradianName: $lGuradianName,
  lGuardianPhone: $lGuardianPhone,
  lClass: $lClass,
  lEnrolledCourse: $lEnrolledCourse,
  lElectiveSubjects: $lElectiveSubjects,
  lAddress: $lAddress,
  lLocation: $lLocation,
  lPhoneNumber: $lPhoneNumber,
  lAlternativePhone: $lAlternativePhone,
  lEmergencyContactNo: $lEmergencyContactNo,
  lEmail: $lEmail,
  lSource: $lSource,
  lResources: $lResources,
  lat: $lat,
  lng: $lng,
  lGender: $lGender,
  lAadharNo: $lAadharNo
)''';
  }

}