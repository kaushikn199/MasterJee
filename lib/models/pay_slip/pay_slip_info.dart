class PaySlipInfoResponse {
  final String status;
  final String message;
  final bool result;
  final PaySlipInfoData? data;

  PaySlipInfoResponse({
    required this.status,
    required this.message,
    required this.result,
    this.data,
  });

  factory PaySlipInfoResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    return PaySlipInfoResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      result: json['result'] ?? false,
      data: rawData != null && rawData is Map<String, dynamic>
          ? PaySlipInfoData.fromJson(rawData)
          : null,
    );
  }
}




class PaySlipInfoData {
  final PaySlipDetails? payslipData;
  final List<Allowance> allowanceAll;
  final List<Allowance> allowancePos;
  final List<Allowance> allowanceNeg;

  PaySlipInfoData({
    this.payslipData,
    required this.allowanceAll,
    required this.allowancePos,
    required this.allowanceNeg,
  });

  factory PaySlipInfoData.fromJson(Map<String, dynamic> json) {
    return PaySlipInfoData(
      payslipData: json['payslipData'] != null ? PaySlipDetails.fromJson(json['payslipData']) : null,
      allowanceAll: (json['allowanceAll'] as List<dynamic>? ?? []).map((e) => Allowance.fromJson(e)).toList(),
      allowancePos: (json['allowancePos'] as List<dynamic>? ?? []).map((e) => Allowance.fromJson(e)).toList(),
      allowanceNeg: (json['allowanceNeg'] as List<dynamic>? ?? []).map((e) => Allowance.fromJson(e)).toList(),
    );
  }
}


class PaySlipDetails {
  final String id;
  final String staffId;
  final String basic;
  final String totalAllowance;
  final String totalDeduction;
  final String leaveDeduction;
  final String tax;
  final String netSalary;
  final String status;
  final String month;
  final String year;
  final String paymentMode;
  final String? linkedLedgerBank;
  final String bankName;
  final String? transactionId;
  final String paymentDate;
  final String remark;
  final String? generatedBy;
  final String createdAt;
  final String paymentModes;
  final String employeeId;
  final String langId;
  final String currencyId;
  final String? department;
  final String designation;
  final String qualification;
  final String workExp;
  final String name;
  final String surname;
  final String fatherName;
  final String motherName;
  final String contactNo;
  final String emergencyContactNo;
  final String email;
  final String dob;
  final String maritalStatus;
  final String? dateOfJoining;
  final String? dateOfLeaving;
  final String localAddress;
  final String permanentAddress;
  final String note;
  final String image;
  final String password;
  final String gender;
  final String accountTitle;
  final String bankAccountNo;
  final String ifscCode;
  final String bankBranch;
  final String payscale;
  final String basicSalary;
  final String epfNo;
  final String contractType;
  final String shift;
  final String location;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String instagram;
  final String resume;
  final String joiningLetter;
  final String resignationLetter;
  final String otherDocumentName;
  final String otherDocumentFile;
  final String userId;
  final String isActive;
  final String? directManager;
  final String isHouseIncharge;
  final String verificationCode;
  final String? zoomApiKey;
  final String? zoomApiSecret;
  final String biometricDeviceId;
  final String? disableAt;
  final String deviceId;
  final String tokenId;
  final String? authToken;
  final String? expiredAt;
  final String? updatedAt;
  final String empId;
  final String psid;

  PaySlipDetails({
    required this.id,
    required this.staffId,
    required this.basic,
    required this.totalAllowance,
    required this.totalDeduction,
    required this.leaveDeduction,
    required this.tax,
    required this.netSalary,
    required this.status,
    required this.month,
    required this.year,
    required this.paymentMode,
    this.linkedLedgerBank,
    required this.bankName,
    this.transactionId,
    required this.paymentDate,
    required this.remark,
    this.generatedBy,
    required this.createdAt,
    required this.paymentModes,
    required this.employeeId,
    required this.langId,
    required this.currencyId,
    this.department,
    required this.designation,
    required this.qualification,
    required this.workExp,
    required this.name,
    required this.surname,
    required this.fatherName,
    required this.motherName,
    required this.contactNo,
    required this.emergencyContactNo,
    required this.email,
    required this.dob,
    required this.maritalStatus,
    this.dateOfJoining,
    this.dateOfLeaving,
    required this.localAddress,
    required this.permanentAddress,
    required this.note,
    required this.image,
    required this.password,
    required this.gender,
    required this.accountTitle,
    required this.bankAccountNo,
    required this.ifscCode,
    required this.bankBranch,
    required this.payscale,
    required this.basicSalary,
    required this.epfNo,
    required this.contractType,
    required this.shift,
    required this.location,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.instagram,
    required this.resume,
    required this.joiningLetter,
    required this.resignationLetter,
    required this.otherDocumentName,
    required this.otherDocumentFile,
    required this.userId,
    required this.isActive,
    this.directManager,
    required this.isHouseIncharge,
    required this.verificationCode,
    this.zoomApiKey,
    this.zoomApiSecret,
    required this.biometricDeviceId,
    this.disableAt,
    required this.deviceId,
    required this.tokenId,
    this.authToken,
    this.expiredAt,
    this.updatedAt,
    required this.empId,
    required this.psid,
  });

  factory PaySlipDetails.fromJson(Map<String, dynamic> json) {
    return PaySlipDetails(
      id: json['id'] ?? "",
      staffId: json['staff_id'] ?? "",
      basic: json['basic'] ?? "0",
      totalAllowance: json['total_allowance'] ?? "0",
      totalDeduction: json['total_deduction'] ?? "0",
      leaveDeduction: json['leave_deduction'] ?? "0",
      tax: json['tax'] ?? "0",
      netSalary: json['net_salary'] ?? "0",
      status: json['status'] ?? "",
      month: json['month'] ?? "",
      year: json['year'] ?? "",
      paymentMode: json['payment_mode'] ?? "",
      linkedLedgerBank: json['linked_ledger_bank'],
      bankName: json['bank_name'] ?? "",
      transactionId: json['transaction_id'],
      paymentDate: json['payment_date'] ?? "",
      remark: json['remark'] ?? "",
      generatedBy: json['generated_by'],
      createdAt: json['created_at'] ?? "",
      paymentModes: json['payment_modes'] ?? "",
      employeeId: json['employee_id'] ?? "",
      langId: json['lang_id'] ?? "",
      currencyId: json['currency_id'] ?? "",
      department: json['department'],
      designation: json['designation'] ?? "",
      qualification: json['qualification'] ?? "",
      workExp: json['work_exp'] ?? "",
      name: json['name'] ?? "",
      surname: json['surname'] ?? "",
      fatherName: json['father_name'] ?? "",
      motherName: json['mother_name'] ?? "",
      contactNo: json['contact_no'] ?? "",
      emergencyContactNo: json['emergency_contact_no'] ?? "",
      email: json['email'] ?? "",
      dob: json['dob'] ?? "",
      maritalStatus: json['marital_status'] ?? "",
      dateOfJoining: json['date_of_joining'],
      dateOfLeaving: json['date_of_leaving'],
      localAddress: json['local_address'] ?? "",
      permanentAddress: json['permanent_address'] ?? "",
      note: json['note'] ?? "",
      image: json['image'] ?? "",
      password: json['password'] ?? "",
      gender: json['gender'] ?? "",
      accountTitle: json['account_title'] ?? "",
      bankAccountNo: json['bank_account_no'] ?? "",
      ifscCode: json['ifsc_code'] ?? "",
      bankBranch: json['bank_branch'] ?? "",
      payscale: json['payscale'] ?? "",
      basicSalary: json['basic_salary'] ?? "",
      epfNo: json['epf_no'] ?? "",
      contractType: json['contract_type'] ?? "",
      shift: json['shift'] ?? "",
      location: json['location'] ?? "",
      facebook: json['facebook'] ?? "",
      twitter: json['twitter'] ?? "",
      linkedin: json['linkedin'] ?? "",
      instagram: json['instagram'] ?? "",
      resume: json['resume'] ?? "",
      joiningLetter: json['joining_letter'] ?? "",
      resignationLetter: json['resignation_letter'] ?? "",
      otherDocumentName: json['other_document_name'] ?? "",
      otherDocumentFile: json['other_document_file'] ?? "",
      userId: json['user_id'] ?? "",
      isActive: json['is_active'] ?? "",
      directManager: json['direct_manager'],
      isHouseIncharge: json['is_house_incharge'] ?? "",
      verificationCode: json['verification_code'] ?? "",
      zoomApiKey: json['zoom_api_key'],
      zoomApiSecret: json['zoom_api_secret'],
      biometricDeviceId: json['biometric_device_id'] ?? "",
      disableAt: json['disable_at'],
      deviceId: json['device_id'] ?? "",
      tokenId: json['token_id'] ?? "",
      authToken: json['auth_token'],
      expiredAt: json['expired_at'],
      updatedAt: json['updated_at'],
      empId: json['empid'] ?? "",
      psid: json['psid'] ?? "",
    );
  }
}

class Allowance {
  final String id;
  final String payslipId;
  final String allowanceType;
  final String amount;
  final String staffId;
  final String calType;

  Allowance({
    required this.id,
    required this.payslipId,
    required this.allowanceType,
    required this.amount,
    required this.staffId,
    required this.calType,
  });

  factory Allowance.fromJson(Map<String, dynamic> json) {
    return Allowance(
      id: json['id'] ?? "",
      payslipId: json['payslip_id'] ?? "",
      allowanceType: json['allowance_type'] ?? "",
      amount: json['amount'] ?? "0",
      staffId: json['staff_id'] ?? "",
      calType: json['cal_type'] ?? "",
    );
  }
}



