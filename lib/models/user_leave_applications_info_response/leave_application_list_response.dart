class UserLeaveApplicationsInfoResponse {
  UserLeaveApplicationsInfoResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  final String status;
  final String message;
  final Data? data;
  final bool result;

  factory UserLeaveApplicationsInfoResponse.fromJson(Map<String, dynamic> json){
    return UserLeaveApplicationsInfoResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      result: json["result"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "result": result,
  };

}

class Data {
  Data({
    required this.lt,
    required this.la,
  });

  final List<Lt> lt;
  final List<La> la;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      lt: json["lt"] == null ? [] : List<Lt>.from(json["lt"]!.map((x) => Lt.fromJson(x))),
      la: json["la"] == null ? [] : List<La>.from(json["la"]!.map((x) => La.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "lt": lt.map((x) => x.toJson()).toList(),
    "la": la.map((x) => x.toJson()).toList(),
  };

}

class La {
  La({
    required this.id,
    required this.staffId,
    required this.leaveTypeId,
    required this.leaveFrom,
    required this.leaveTo,
    required this.leaveDays,
    required this.employeeRemark,
    required this.adminRemark,
    required this.status,
    required this.appliedBy,
    required this.documentFile,
    required this.date,
    required this.createdAt,
    required this.type,
    required this.isActive,
    required this.ltid,
  });

  final String id;
  final String staffId;
  final String leaveTypeId;
  final String? leaveFrom;
  final String? leaveTo;
  final String leaveDays;
  final String employeeRemark;
  final String adminRemark;
  final String status;
  final dynamic appliedBy;
  final String documentFile;
  final String date;
  final String? createdAt;
  final String type;
  final String isActive;
  final String ltid;

  factory La.fromJson(Map<String, dynamic> json){
    return La(
      id: json["id"] ?? "",
      staffId: json["staff_id"] ?? "",
      leaveTypeId: json["leave_type_id"] ?? "",
      leaveFrom:json["leave_from"] ?? "",
      leaveTo: json["leave_to"] ?? "",
      leaveDays: json["leave_days"] ?? "",
      employeeRemark: json["employee_remark"] ?? "",
      adminRemark: json["admin_remark"] ?? "",
      status: json["status"] ?? "",
      appliedBy: json["applied_by"],
      documentFile: json["document_file"] ?? "",
      date: json["date"] ?? "",
      createdAt: json["created_at"] ?? "",
      type: json["type"] ?? "",
      isActive: json["is_active"] ?? "",
      ltid: json["ltid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "staff_id": staffId,
    "leave_type_id": leaveTypeId,
    "leave_from": leaveFrom,
    "leave_to": leaveTo,
    "leave_days": leaveDays,
    "employee_remark": employeeRemark,
    "admin_remark": adminRemark,
    "status": status,
    "applied_by": appliedBy,
    "document_file": documentFile,
    "date": date,
    "created_at": createdAt,
    "is_active": isActive,
    "ltid": ltid,
  };

}

class Lt {
  Lt({
    required this.id,
    required this.staffId,
    required this.leaveTypeId,
    required this.ltAllotedLeave,
    required this.type,
    required this.isActive,
    required this.ltid,
    required this.allotedLeave,
    required this.takenLeave,
    required this.pendingLeave,
  });

  final String id;
  final String staffId;
  final String leaveTypeId;
  final String ltAllotedLeave;
  final String type;
  final String isActive;
  final String ltid;
  final int allotedLeave;
  final dynamic takenLeave;
  final int pendingLeave;

  factory Lt.fromJson(Map<String, dynamic> json){
    return Lt(
      id: json["id"] ?? "",
      staffId: json["staff_id"] ?? "",
      leaveTypeId: json["leave_type_id"] ?? "",
      ltAllotedLeave: json["alloted_leave"] ?? "",
      type: json["type"] ?? "",
      isActive: json["is_active"] ?? "",
      ltid: json["ltid"] ?? "",
      allotedLeave: json["allotedLeave"] ?? 0,
      takenLeave: json["takenLeave"],
      pendingLeave: json["pendingLeave"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "staff_id": staffId,
    "leave_type_id": leaveTypeId,
    "alloted_leave": ltAllotedLeave,
    "type": type,
    "is_active": isActive,
    "ltid": ltid,
    "allotedLeave": allotedLeave,
    "takenLeave": takenLeave,
    "pendingLeave": pendingLeave,
  };

}
