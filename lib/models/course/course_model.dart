class AllCourseData {
  String? status;
  String? message;
  Data? data;
  bool? result;

  AllCourseData({
    this.status,
    this.message,
    this.data,
    this.result,
  });

  factory AllCourseData.fromJson(Map<String, dynamic> json) => AllCourseData(
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
  List<Courses>? courses;
  List<Category>? category;

  Data({
    this.courses,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    courses: json["courses"] == null ? [] : List<Courses>.from(json["courses"]!.map((x) => Courses.fromJson(x))),
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
  };
}

class Category {
  String? id;
  String? categoryName;
  dynamic slug;
  dynamic isActive;

  Category({
    this.id,
    this.categoryName,
    this.slug,
    this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["category_name"],
    slug: json["slug"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "slug": slug,
    "is_active": isActive,
  };
}

class Courses {
  String? id;
  String? title;
  dynamic slug;
  String? url;
  String? description;
  String? teacherId;
  String? categoryId;
  String? outcomes;
  dynamic courseThumbnail;
  String? courseProvider;
  String? courseUrl;
  String? videoId;
  String? price;
  String? discount;
  String? freeCourse;
  dynamic viewCount;
  String? frontSideVisibility;
  String? status;
  String? createdBy;
  DateTime? createdDate;
  DateTime? updatedDate;
  String? categoryName;
  String? isActive;
  String? employeeId;
  String? langId;
  String? currencyId;
  String? department;
  String? designation;
  String? qualification;
  String? workExp;
  String? name;
  String? surname;
  String? fatherName;
  String? motherName;
  String? contactNo;
  String? emergencyContactNo;
  String? email;
  DateTime? dob;
  String? maritalStatus;
  DateTime? dateOfJoining;
  dynamic dateOfLeaving;
  String? localAddress;
  String? permanentAddress;
  String? note;
  String? image;
  String? password;
  String? gender;
  String? accountTitle;
  String? bankAccountNo;
  String? bankName;
  String? ifscCode;
  String? bankBranch;
  String? payscale;
  String? basicSalary;
  String? epfNo;
  String? contractType;
  String? shift;
  String? location;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? instagram;
  String? resume;
  String? joiningLetter;
  String? resignationLetter;
  String? otherDocumentName;
  String? otherDocumentFile;
  String? userId;
  dynamic directManager;
  String? isHouseIncharge;
  String? verificationCode;
  dynamic zoomApiKey;
  dynamic zoomApiSecret;
  dynamic biometricDeviceId;
  dynamic disableAt;
  String? deviceId;
  String? tokenId;
  dynamic authToken;
  dynamic expiredAt;
  dynamic updatedAt;
  String? courseId;
  String? classSectionId;
  String? classId;
  String? sectionId;
  DateTime? createdAt;
  String? ocid;
  List<Section>? sections;

  Courses({
    this.id,
    this.title,
    this.slug,
    this.url,
    this.description,
    this.teacherId,
    this.categoryId,
    this.outcomes,
    this.courseThumbnail,
    this.courseProvider,
    this.courseUrl,
    this.videoId,
    this.price,
    this.discount,
    this.freeCourse,
    this.viewCount,
    this.frontSideVisibility,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedDate,
    this.categoryName,
    this.isActive,
    this.employeeId,
    this.langId,
    this.currencyId,
    this.department,
    this.designation,
    this.qualification,
    this.workExp,
    this.name,
    this.surname,
    this.fatherName,
    this.motherName,
    this.contactNo,
    this.emergencyContactNo,
    this.email,
    this.dob,
    this.maritalStatus,
    this.dateOfJoining,
    this.dateOfLeaving,
    this.localAddress,
    this.permanentAddress,
    this.note,
    this.image,
    this.password,
    this.gender,
    this.accountTitle,
    this.bankAccountNo,
    this.bankName,
    this.ifscCode,
    this.bankBranch,
    this.payscale,
    this.basicSalary,
    this.epfNo,
    this.contractType,
    this.shift,
    this.location,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
    this.resume,
    this.joiningLetter,
    this.resignationLetter,
    this.otherDocumentName,
    this.otherDocumentFile,
    this.userId,
    this.directManager,
    this.isHouseIncharge,
    this.verificationCode,
    this.zoomApiKey,
    this.zoomApiSecret,
    this.biometricDeviceId,
    this.disableAt,
    this.deviceId,
    this.tokenId,
    this.authToken,
    this.expiredAt,
    this.updatedAt,
    this.courseId,
    this.classSectionId,
    this.classId,
    this.sectionId,
    this.createdAt,
    this.ocid,
    this.sections,
  });

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    url: json["url"],
    description: json["description"],
    teacherId: json["teacher_id"],
    categoryId: json["category_id"],
    outcomes: json["outcomes"],
    courseThumbnail: json["course_thumbnail"],
    courseProvider: json["course_provider"],
    courseUrl: json["course_url"],
    videoId: json["video_id"],
    price: json["price"],
    discount: json["discount"],
    freeCourse: json["free_course"],
    viewCount: json["view_count"],
    frontSideVisibility: json["front_side_visibility"],
    status: json["status"],
    createdBy: json["created_by"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    updatedDate: json["updated_date"] == null ? null : DateTime.parse(json["updated_date"]),
    categoryName: json["category_name"],
    isActive: json["is_active"],
    employeeId: json["employee_id"],
    langId: json["lang_id"],
    currencyId: json["currency_id"],
    department: json["department"],
    designation: json["designation"],
    qualification: json["qualification"],
    workExp: json["work_exp"],
    name: json["name"],
    surname: json["surname"],
    fatherName: json["father_name"],
    motherName: json["mother_name"],
    contactNo: json["contact_no"],
    emergencyContactNo: json["emergency_contact_no"],
    email: json["email"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    maritalStatus: json["marital_status"],
    dateOfJoining: json["date_of_joining"] == null ? null : DateTime.parse(json["date_of_joining"]),
    dateOfLeaving: json["date_of_leaving"],
    localAddress: json["local_address"],
    permanentAddress: json["permanent_address"],
    note: json["note"],
    image: json["image"],
    password: json["password"],
    gender: json["gender"],
    accountTitle: json["account_title"],
    bankAccountNo: json["bank_account_no"],
    bankName: json["bank_name"],
    ifscCode: json["ifsc_code"],
    bankBranch: json["bank_branch"],
    payscale: json["payscale"],
    basicSalary: json["basic_salary"],
    epfNo: json["epf_no"],
    contractType: json["contract_type"],
    shift: json["shift"],
    location: json["location"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    linkedin: json["linkedin"],
    instagram: json["instagram"],
    resume: json["resume"],
    joiningLetter: json["joining_letter"],
    resignationLetter: json["resignation_letter"],
    otherDocumentName: json["other_document_name"],
    otherDocumentFile: json["other_document_file"],
    userId: json["user_id"],
    directManager: json["direct_manager"],
    isHouseIncharge: json["is_house_incharge"],
    verificationCode: json["verification_code"],
    zoomApiKey: json["zoom_api_key"],
    zoomApiSecret: json["zoom_api_secret"],
    biometricDeviceId: json["biometric_device_id"],
    disableAt: json["disable_at"],
    deviceId: json["device_id"],
    tokenId: json["token_id"],
    authToken: json["auth_token"],
    expiredAt: json["expired_at"],
    updatedAt: json["updated_at"],
    courseId: json["course_id"],
    classSectionId: json["class_section_id"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    ocid: json["ocid"],
    sections: json["sections"] == null ? [] : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "url": url,
    "description": description,
    "teacher_id": teacherId,
    "category_id": categoryId,
    "outcomes": outcomes,
    "course_thumbnail": courseThumbnail,
    "course_provider": courseProvider,
    "course_url": courseUrl,
    "video_id": videoId,
    "price": price,
    "discount": discount,
    "free_course": freeCourse,
    "view_count": viewCount,
    "front_side_visibility": frontSideVisibility,
    "status": status,
    "created_by": createdBy,
    "created_date": createdDate?.toIso8601String(),
    "updated_date": updatedDate?.toIso8601String(),
    "category_name": categoryName,
    "is_active": isActive,
    "employee_id": employeeId,
    "lang_id": langId,
    "currency_id": currencyId,
    "department": department,
    "designation": designation,
    "qualification": qualification,
    "work_exp": workExp,
    "name": name,
    "surname": surname,
    "father_name": fatherName,
    "mother_name": motherName,
    "contact_no": contactNo,
    "emergency_contact_no": emergencyContactNo,
    "email": email,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "marital_status": maritalStatus,
    "date_of_joining": "${dateOfJoining!.year.toString().padLeft(4, '0')}-${dateOfJoining!.month.toString().padLeft(2, '0')}-${dateOfJoining!.day.toString().padLeft(2, '0')}",
    "date_of_leaving": dateOfLeaving,
    "local_address": localAddress,
    "permanent_address": permanentAddress,
    "note": note,
    "image": image,
    "password": password,
    "gender": gender,
    "account_title": accountTitle,
    "bank_account_no": bankAccountNo,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "bank_branch": bankBranch,
    "payscale": payscale,
    "basic_salary": basicSalary,
    "epf_no": epfNo,
    "contract_type": contractType,
    "shift": shift,
    "location": location,
    "facebook": facebook,
    "twitter": twitter,
    "linkedin": linkedin,
    "instagram": instagram,
    "resume": resume,
    "joining_letter": joiningLetter,
    "resignation_letter": resignationLetter,
    "other_document_name": otherDocumentName,
    "other_document_file": otherDocumentFile,
    "user_id": userId,
    "direct_manager": directManager,
    "is_house_incharge": isHouseIncharge,
    "verification_code": verificationCode,
    "zoom_api_key": zoomApiKey,
    "zoom_api_secret": zoomApiSecret,
    "biometric_device_id": biometricDeviceId,
    "disable_at": disableAt,
    "device_id": deviceId,
    "token_id": tokenId,
    "auth_token": authToken,
    "expired_at": expiredAt,
    "updated_at": updatedAt,
    "course_id": courseId,
    "class_section_id": classSectionId,
    "class_id": classId,
    "section_id": sectionId,
    "created_at": createdAt?.toIso8601String(),
    "ocid": ocid,
    "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}


class SuccessData {
  String? status;
  String? message;
  dynamic data;
  bool? result;

  SuccessData({
    this.status,
    this.message,
    this.data,
    this.result,
  });

  factory SuccessData.fromJson(Map<String, dynamic> json) => SuccessData(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "result": result,
  };
}


class Section {
  String? id;
  String? onlineCourseId;
  String? sectionTitle;
  dynamic order;
  dynamic isActive;

  Section({
    this.id,
    this.onlineCourseId,
    this.sectionTitle,
    this.order,
    this.isActive,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    onlineCourseId: json["online_course_id"],
    sectionTitle: json["section_title"],
    order: json["order"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "online_course_id": onlineCourseId,
    "section_title": sectionTitle,
    "order": order,
    "is_active": isActive,
  };
}
