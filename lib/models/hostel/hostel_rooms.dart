class HostelRoomsData {
  String? status;
  String? message;
  Data? data;
  bool? result;

  HostelRoomsData({this.status, this.message, this.data, this.result});

  HostelRoomsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['result'] = result;
    return data;
  }
}

class Data {
  List<HostelsForRooms>? hostels;
  List<HRooms>? rooms;
  List<Roomtypes>? roomtypes;
  List<Staffs>? staffs;

  Data({this.hostels, this.rooms, this.roomtypes, this.staffs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['hostels'] != null) {
      hostels = <HostelsForRooms>[];
      json['hostels'].forEach((v) {
        hostels!.add(HostelsForRooms.fromJson(v));
      });
    }
    if (json['rooms'] != null) {
      rooms = <HRooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(HRooms.fromJson(v));
      });
    }
    if (json['roomtypes'] != null) {
      roomtypes = <Roomtypes>[];
      json['roomtypes'].forEach((v) {
        roomtypes!.add(Roomtypes.fromJson(v));
      });
    }
    if (json['staffs'] != null) {
      staffs = <Staffs>[];
      json['staffs'].forEach((v) {
        staffs!.add(Staffs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hostels != null) {
      data['hostels'] = hostels!.map((v) => v.toJson()).toList();
    }
    if (rooms != null) {
      data['rooms'] = rooms!.map((v) => v.toJson()).toList();
    }
    if (roomtypes != null) {
      data['roomtypes'] = roomtypes!.map((v) => v.toJson()).toList();
    }
    if (staffs != null) {
      data['staffs'] = staffs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HostelsForRooms {
  String? id;
  String? hostelName;
  String? type;
  String? address;
  String? intake;
  String? description;
  String? hostelIncharge;
  String? isActive;
  String? createdAt;
  Null? updatedAt;
  String? mealType;
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
  String? dob;
  String? maritalStatus;
  String? dateOfJoining;
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
  String? directManager;
  String? isHouseIncharge;
  String? verificationCode;
  dynamic zoomApiKey;
  dynamic zoomApiSecret;
  String? biometricDeviceId;
  dynamic disableAt;
  String? deviceId;
  String? tokenId;
  dynamic authToken;
  dynamic expiredAt;
  String? hid;
  List<HRooms>? hRooms;

  HostelsForRooms(
      {this.id,
        this.hostelName,
        this.type,
        this.address,
        this.intake,
        this.description,
        this.hostelIncharge,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.mealType,
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
        this.hid,
        this.hRooms});

  HostelsForRooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hostelName = json['hostel_name'];
    type = json['type'];
    address = json['address'];
    intake = json['intake'];
    description = json['description'];
    hostelIncharge = json['hostel_incharge'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mealType = json['meal_type'];
    employeeId = json['employee_id'];
    langId = json['lang_id'];
    currencyId = json['currency_id'];
    department = json['department'];
    designation = json['designation'];
    qualification = json['qualification'];
    workExp = json['work_exp'];
    name = json['name'];
    surname = json['surname'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    contactNo = json['contact_no'];
    emergencyContactNo = json['emergency_contact_no'];
    email = json['email'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    dateOfJoining = json['date_of_joining'];
    dateOfLeaving = json['date_of_leaving'];
    localAddress = json['local_address'];
    permanentAddress = json['permanent_address'];
    note = json['note'];
    image = json['image'];
    password = json['password'];
    gender = json['gender'];
    accountTitle = json['account_title'];
    bankAccountNo = json['bank_account_no'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    bankBranch = json['bank_branch'];
    payscale = json['payscale'];
    basicSalary = json['basic_salary'];
    epfNo = json['epf_no'];
    contractType = json['contract_type'];
    shift = json['shift'];
    location = json['location'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    resume = json['resume'];
    joiningLetter = json['joining_letter'];
    resignationLetter = json['resignation_letter'];
    otherDocumentName = json['other_document_name'];
    otherDocumentFile = json['other_document_file'];
    userId = json['user_id'];
    directManager = json['direct_manager'];
    isHouseIncharge = json['is_house_incharge'];
    verificationCode = json['verification_code'];
    zoomApiKey = json['zoom_api_key'];
    zoomApiSecret = json['zoom_api_secret'];
    biometricDeviceId = json['biometric_device_id'];
    disableAt = json['disable_at'];
    deviceId = json['device_id'];
    tokenId = json['token_id'];
    authToken = json['auth_token'];
    expiredAt = json['expired_at'];
    hid = json['hid'];
    if (json['hRooms'] != null) {
      hRooms = <HRooms>[];
      json['hRooms'].forEach((v) {
        hRooms!.add(HRooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hostel_name'] = hostelName;
    data['type'] = type;
    data['address'] = address;
    data['intake'] = intake;
    data['description'] = description;
    data['hostel_incharge'] = hostelIncharge;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['meal_type'] = mealType;
    data['employee_id'] = employeeId;
    data['lang_id'] = langId;
    data['currency_id'] = currencyId;
    data['department'] = department;
    data['designation'] = designation;
    data['qualification'] = qualification;
    data['work_exp'] = workExp;
    data['name'] = name;
    data['surname'] = surname;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['contact_no'] = contactNo;
    data['emergency_contact_no'] = emergencyContactNo;
    data['email'] = email;
    data['dob'] = dob;
    data['marital_status'] = maritalStatus;
    data['date_of_joining'] = dateOfJoining;
    data['date_of_leaving'] = dateOfLeaving;
    data['local_address'] = localAddress;
    data['permanent_address'] = permanentAddress;
    data['note'] = note;
    data['image'] = image;
    data['password'] = password;
    data['gender'] = gender;
    data['account_title'] = accountTitle;
    data['bank_account_no'] = bankAccountNo;
    data['bank_name'] = bankName;
    data['ifsc_code'] = ifscCode;
    data['bank_branch'] = bankBranch;
    data['payscale'] = payscale;
    data['basic_salary'] = basicSalary;
    data['epf_no'] = epfNo;
    data['contract_type'] = contractType;
    data['shift'] = shift;
    data['location'] = location;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['instagram'] = instagram;
    data['resume'] = resume;
    data['joining_letter'] = joiningLetter;
    data['resignation_letter'] = resignationLetter;
    data['other_document_name'] = otherDocumentName;
    data['other_document_file'] = otherDocumentFile;
    data['user_id'] = userId;
    data['direct_manager'] = directManager;
    data['is_house_incharge'] = isHouseIncharge;
    data['verification_code'] = verificationCode;
    data['zoom_api_key'] = zoomApiKey;
    data['zoom_api_secret'] = zoomApiSecret;
    data['biometric_device_id'] = biometricDeviceId;
    data['disable_at'] = disableAt;
    data['device_id'] = deviceId;
    data['token_id'] = tokenId;
    data['auth_token'] = authToken;
    data['expired_at'] = expiredAt;
    data['hid'] = hid;
    if (hRooms != null) {
      data['hRooms'] = hRooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HRooms {
  String? id;
  String? hostelId;
  String? roomTypeId;
  String? roomNo;
  String? noOfBed;
  String? costPerBed;
  String? costTerm;
  dynamic title;
  String? feeTitle;
  String? description;
  String? createdAt;
  String? hostelName;
  String? type;
  String? address;
  String? intake;
  String? hostelIncharge;
  String? isActive;
  dynamic updatedAt;
  String? mealType;
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
  String? dob;
  String? maritalStatus;
  String? dateOfJoining;
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
  String? directManager;
  String? isHouseIncharge;
  String? verificationCode;
  dynamic zoomApiKey;
  dynamic zoomApiSecret;
  String? biometricDeviceId;
  dynamic disableAt;
  String? deviceId;
  String? tokenId;
  dynamic authToken;
  dynamic expiredAt;
  String? roomType;
  String? hrid;

  HRooms(
      {this.id,
        this.hostelId,
        this.roomTypeId,
        this.roomNo,
        this.noOfBed,
        this.costPerBed,
        this.costTerm,
        this.title,
        this.feeTitle,
        this.description,
        this.createdAt,
        this.hostelName,
        this.type,
        this.address,
        this.intake,
        this.hostelIncharge,
        this.isActive,
        this.updatedAt,
        this.mealType,
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
        this.roomType,
        this.hrid});

  HRooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hostelId = json['hostel_id'];
    roomTypeId = json['room_type_id'];
    roomNo = json['room_no'];
    noOfBed = json['no_of_bed'];
    costPerBed = json['cost_per_bed'];
    costTerm = json['cost_term'];
    title = json['title'];
    feeTitle = json['fee_title'];
    description = json['description'];
    createdAt = json['created_at'];
    hostelName = json['hostel_name'];
    type = json['type'];
    address = json['address'];
    intake = json['intake'];
    hostelIncharge = json['hostel_incharge'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
    mealType = json['meal_type'];
    employeeId = json['employee_id'];
    langId = json['lang_id'];
    currencyId = json['currency_id'];
    department = json['department'];
    designation = json['designation'];
    qualification = json['qualification'];
    workExp = json['work_exp'];
    name = json['name'];
    surname = json['surname'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    contactNo = json['contact_no'];
    emergencyContactNo = json['emergency_contact_no'];
    email = json['email'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    dateOfJoining = json['date_of_joining'];
    dateOfLeaving = json['date_of_leaving'];
    localAddress = json['local_address'];
    permanentAddress = json['permanent_address'];
    note = json['note'];
    image = json['image'];
    password = json['password'];
    gender = json['gender'];
    accountTitle = json['account_title'];
    bankAccountNo = json['bank_account_no'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    bankBranch = json['bank_branch'];
    payscale = json['payscale'];
    basicSalary = json['basic_salary'];
    epfNo = json['epf_no'];
    contractType = json['contract_type'];
    shift = json['shift'];
    location = json['location'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    resume = json['resume'];
    joiningLetter = json['joining_letter'];
    resignationLetter = json['resignation_letter'];
    otherDocumentName = json['other_document_name'];
    otherDocumentFile = json['other_document_file'];
    userId = json['user_id'];
    directManager = json['direct_manager'];
    isHouseIncharge = json['is_house_incharge'];
    verificationCode = json['verification_code'];
    zoomApiKey = json['zoom_api_key'];
    zoomApiSecret = json['zoom_api_secret'];
    biometricDeviceId = json['biometric_device_id'];
    disableAt = json['disable_at'];
    deviceId = json['device_id'];
    tokenId = json['token_id'];
    authToken = json['auth_token'];
    expiredAt = json['expired_at'];
    roomType = json['room_type'];
    hrid = json['hrid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hostel_id'] = hostelId;
    data['room_type_id'] = roomTypeId;
    data['room_no'] = roomNo;
    data['no_of_bed'] = noOfBed;
    data['cost_per_bed'] = costPerBed;
    data['cost_term'] = costTerm;
    data['title'] = title;
    data['fee_title'] = feeTitle;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['hostel_name'] = hostelName;
    data['type'] = type;
    data['address'] = address;
    data['intake'] = intake;
    data['hostel_incharge'] = hostelIncharge;
    data['is_active'] = isActive;
    data['updated_at'] = updatedAt;
    data['meal_type'] = mealType;
    data['employee_id'] = employeeId;
    data['lang_id'] = langId;
    data['currency_id'] = currencyId;
    data['department'] = department;
    data['designation'] = designation;
    data['qualification'] = qualification;
    data['work_exp'] = workExp;
    data['name'] = name;
    data['surname'] = surname;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['contact_no'] = contactNo;
    data['emergency_contact_no'] = emergencyContactNo;
    data['email'] = email;
    data['dob'] = dob;
    data['marital_status'] = maritalStatus;
    data['date_of_joining'] = dateOfJoining;
    data['date_of_leaving'] = dateOfLeaving;
    data['local_address'] = localAddress;
    data['permanent_address'] = permanentAddress;
    data['note'] = note;
    data['image'] = image;
    data['password'] = password;
    data['gender'] = gender;
    data['account_title'] = accountTitle;
    data['bank_account_no'] = bankAccountNo;
    data['bank_name'] = bankName;
    data['ifsc_code'] = ifscCode;
    data['bank_branch'] = bankBranch;
    data['payscale'] = payscale;
    data['basic_salary'] = basicSalary;
    data['epf_no'] = epfNo;
    data['contract_type'] = contractType;
    data['shift'] = shift;
    data['location'] = location;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['instagram'] = instagram;
    data['resume'] = resume;
    data['joining_letter'] = joiningLetter;
    data['resignation_letter'] = resignationLetter;
    data['other_document_name'] = otherDocumentName;
    data['other_document_file'] = otherDocumentFile;
    data['user_id'] = userId;
    data['direct_manager'] = directManager;
    data['is_house_incharge'] = isHouseIncharge;
    data['verification_code'] = verificationCode;
    data['zoom_api_key'] = zoomApiKey;
    data['zoom_api_secret'] = zoomApiSecret;
    data['biometric_device_id'] = biometricDeviceId;
    data['disable_at'] = disableAt;
    data['device_id'] = deviceId;
    data['token_id'] = tokenId;
    data['auth_token'] = authToken;
    data['expired_at'] = expiredAt;
    data['room_type'] = roomType;
    data['hrid'] = hrid;
    return data;
  }
}

class Roomtypes {
  String? id;
  String? roomType;
  String? description;
  String? createdAt;
  dynamic updatedAt;

  Roomtypes(
      {this.id,
        this.roomType,
        this.description,
        this.createdAt,
        this.updatedAt});

  Roomtypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomType = json['room_type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_type'] = roomType;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Staffs {
  String? id;
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
  String? dob;
  String? maritalStatus;
  String? dateOfJoining;
  String? dateOfLeaving;
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
  String? isActive;
  String? directManager;
  String? isHouseIncharge;
  String? verificationCode;
  dynamic zoomApiKey;
  dynamic zoomApiSecret;
  String? biometricDeviceId;
  dynamic disableAt;
  String? deviceId;
  String? tokenId;
  dynamic authToken;
  dynamic expiredAt;
  dynamic updatedAt;

  Staffs(
      {this.id,
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
        this.isActive,
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
        this.updatedAt});

  Staffs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    langId = json['lang_id'];
    currencyId = json['currency_id'];
    department = json['department'];
    designation = json['designation'];
    qualification = json['qualification'];
    workExp = json['work_exp'];
    name = json['name'];
    surname = json['surname'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    contactNo = json['contact_no'];
    emergencyContactNo = json['emergency_contact_no'];
    email = json['email'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    dateOfJoining = json['date_of_joining'];
    dateOfLeaving = json['date_of_leaving'];
    localAddress = json['local_address'];
    permanentAddress = json['permanent_address'];
    note = json['note'];
    image = json['image'];
    password = json['password'];
    gender = json['gender'];
    accountTitle = json['account_title'];
    bankAccountNo = json['bank_account_no'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    bankBranch = json['bank_branch'];
    payscale = json['payscale'];
    basicSalary = json['basic_salary'];
    epfNo = json['epf_no'];
    contractType = json['contract_type'];
    shift = json['shift'];
    location = json['location'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    resume = json['resume'];
    joiningLetter = json['joining_letter'];
    resignationLetter = json['resignation_letter'];
    otherDocumentName = json['other_document_name'];
    otherDocumentFile = json['other_document_file'];
    userId = json['user_id'];
    isActive = json['is_active'];
    directManager = json['direct_manager'];
    isHouseIncharge = json['is_house_incharge'];
    verificationCode = json['verification_code'];
    zoomApiKey = json['zoom_api_key'];
    zoomApiSecret = json['zoom_api_secret'];
    biometricDeviceId = json['biometric_device_id'];
    disableAt = json['disable_at'];
    deviceId = json['device_id'];
    tokenId = json['token_id'];
    authToken = json['auth_token'];
    expiredAt = json['expired_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['lang_id'] = langId;
    data['currency_id'] = currencyId;
    data['department'] = department;
    data['designation'] = designation;
    data['qualification'] = qualification;
    data['work_exp'] = workExp;
    data['name'] = name;
    data['surname'] = surname;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['contact_no'] = contactNo;
    data['emergency_contact_no'] = emergencyContactNo;
    data['email'] = email;
    data['dob'] = dob;
    data['marital_status'] = maritalStatus;
    data['date_of_joining'] = dateOfJoining;
    data['date_of_leaving'] = dateOfLeaving;
    data['local_address'] = localAddress;
    data['permanent_address'] = permanentAddress;
    data['note'] = note;
    data['image'] = image;
    data['password'] = password;
    data['gender'] = gender;
    data['account_title'] = accountTitle;
    data['bank_account_no'] = bankAccountNo;
    data['bank_name'] = bankName;
    data['ifsc_code'] = ifscCode;
    data['bank_branch'] = bankBranch;
    data['payscale'] = payscale;
    data['basic_salary'] = basicSalary;
    data['epf_no'] = epfNo;
    data['contract_type'] = contractType;
    data['shift'] = shift;
    data['location'] = location;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['instagram'] = instagram;
    data['resume'] = resume;
    data['joining_letter'] = joiningLetter;
    data['resignation_letter'] = resignationLetter;
    data['other_document_name'] = otherDocumentName;
    data['other_document_file'] = otherDocumentFile;
    data['user_id'] = userId;
    data['is_active'] = isActive;
    data['direct_manager'] = directManager;
    data['is_house_incharge'] = isHouseIncharge;
    data['verification_code'] = verificationCode;
    data['zoom_api_key'] = zoomApiKey;
    data['zoom_api_secret'] = zoomApiSecret;
    data['biometric_device_id'] = biometricDeviceId;
    data['disable_at'] = disableAt;
    data['device_id'] = deviceId;
    data['token_id'] = tokenId;
    data['auth_token'] = authToken;
    data['expired_at'] = expiredAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
